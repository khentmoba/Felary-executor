#include <Exploit/Utils.hpp>
#include <Exploit/Globals.hpp>
#include <Communication/Communication.hpp>
#include <Exploit/TaskScheduler/TaskScheduler.hpp>

void MainThread()
{
    Communication::Initialize();

    // Safety gate: function offsets (Print, Luau_Execute, …) are still
    // from version-ad5d3e2906444472. Running SetupExploit with them would
    // call into garbage and crash the client. Park here — reads only,
    // no writes, no calls into Roblox code — until Offsets.hpp is fully
    // re-dumped and kOffsetsVerified is flipped. Visible in a debugger
    // via OutputDebugString (Roblox::Print itself is stale, can't use it).
    if (!Offsets::kOffsetsVerified)
    {
        OutputDebugStringA("FelaryExecutor: function offsets STALE — exploit disabled, "
            "update Roblox/Offsets.hpp before injecting for real.");
        while (true)
            std::this_thread::sleep_for(std::chrono::milliseconds(5000));
    }

    while (true)
    {
        uintptr_t DataModel = TaskScheduler::GetDataModel();
        if (!DataModel)
        {
            std::this_thread::sleep_for(std::chrono::milliseconds(1000));
            continue;
		}

        if (SharedVariables::LastDataModel != DataModel)
        {
            if (!Utils::IsInGame(DataModel))
            {
                std::this_thread::sleep_for(std::chrono::milliseconds(1000));
                continue;
            }
            SharedVariables::LastDataModel = DataModel;
			SharedVariables::ExecutionRequests.clear();

            TaskScheduler::SetupExploit();
            TaskScheduler::RequestExecution("print(\"Felary Executor successfully loaded\")");
        }

        std::this_thread::sleep_for(std::chrono::milliseconds(1000));
    }
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved)
{
    if (ul_reason_for_call == DLL_PROCESS_ATTACH)
    {
        DisableThreadLibraryCalls(hModule);
        std::thread(MainThread).detach();
    }

    return TRUE;
}