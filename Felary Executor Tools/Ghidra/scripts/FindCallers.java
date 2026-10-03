// Post-analysis helper: list code xrefs (callers/referrers) to ImageBase+RVA.
// Usage: -postScript FindCallers.java 0x2699CF3
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.symbol.Reference;
import ghidra.program.model.symbol.ReferenceIterator;

public class FindCallers extends GhidraScript {
    @Override
    public void run() throws Exception {
        long rva = Long.decode(getScriptArgs()[0]);
        Address addr = currentProgram.getImageBase().add(rva);
        println("=== xrefs to " + addr + " ===");
        ReferenceIterator it = currentProgram.getReferenceManager().getReferencesTo(addr);
        int n = 0;
        for (Reference ref : it) {
            println("  " + ref.getFromAddress() + " [" + ref.getReferenceType() + "]");
            if (++n > 60) {
                println("  ... truncated");
                break;
            }
        }
        if (n == 0) {
            println("  (none — address may be in a still-encrypted region)");
        }
    }
}
