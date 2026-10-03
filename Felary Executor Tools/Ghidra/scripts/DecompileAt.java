// Ghidra headless helper: create a function at ImageBase+RVA and decompile it.
// Usage (from the Ghidra/work dir):
//   analyzeHeadless.bat . felary -process dumped.exe -noanalysis
//       -scriptPath <scripts dir> -postScript DecompileAt.java 0x2681D50
import ghidra.app.decompile.DecompInterface;
import ghidra.app.decompile.DecompileResults;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.Function;

public class DecompileAt extends GhidraScript {
    @Override
    public void run() throws Exception {
        String[] args = getScriptArgs();
        long rva = Long.decode(args[0]);
        Address addr = currentProgram.getImageBase().add(rva);
        Function func = getFunctionAt(addr);
        if (func == null) {
            func = createFunction(addr, null);
            println("created function at " + addr);
        }
        else {
            println("function exists at " + addr);
        }
        DecompInterface decomp = new DecompInterface();
        decomp.openProgram(currentProgram);
        DecompileResults res = decomp.decompileFunction(func, 60, monitor);
        println("=== decompile " + addr + " ===");
        if (res != null && res.getDecompiledFunction() != null) {
            println(res.getDecompiledFunction().getC());
        }
        else {
            println("<FAILED>");
        }
    }
}
