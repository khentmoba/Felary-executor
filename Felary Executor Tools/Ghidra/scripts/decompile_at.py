# Ghidra headless helper: create a function at ImageBase+RVA and decompile it.
# Usage (from the Ghidra/work dir):
#   analyzeHeadless.bat . felary -process dumped.exe -noanalysis \
#       -postScript decompile_at.py 0x2681D50
from ghidra.app.decompile import DecompInterface

args = getScriptArgs()
rva = int(args[0], 16)
base = currentProgram.getImageBase()
addr = base.add(rva)

listing = currentProgram.getListing()
func = listing.getFunctionAt(addr)
if func is None:
    func = createFunction(addr, None)
    print("created function at {}".format(addr))
else:
    print("function already exists at {}".format(addr))

decomp = DecompInterface()
decomp.openProgram(currentProgram)
res = decomp.decompileFunction(func, 60, monitor)
print("=== decompile {} ===".format(addr))
print(res.getDecompiledFunction().getC() if res and res.getDecompiledFunction() else "<FAILED>")
