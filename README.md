# Learning Q#

Tim Smith

Learning Q# on my M3 Macbook Air 16gb

## Setup

### Env

```
python3 -m venv q#_en
source q#_env/bin/activate
python -m pip install qsharp azure-quantum
python -m pip install ipykernel ipympl jupyterlab
```

### Azure/DotNET

```
brew update && brew install azure-cli
dotnet new install Microsoft.Quantum.ProjectTemplate
dotnet dev-certs https --trust
dotnet new console -lang Q# -o MyQsharpProject
```

#### Main.qs

```
namespace EntanglementDemo {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    @EntryPoint()
    operation Main() : (Result, Result) {
        // Allocate two qubits, q1 and q2, in the 0 state.
        use (q1, q2) = (Qubit(), Qubit());

        // Put q1 into an even superposition.
        // It now has a 50% chance of being measured as 0 or 1.
        H(q1);

        // Entangle q1 and q2, making q2 depend on q1.
        CNOT(q1, q2);

        // Show the entangled state of the qubits.
        DumpMachine();

        // Measure q1 and q2 and store the results in m1 and m2.
        let (m1, m2) = (M(q1), M(q2));

        // Reset q1 and q2 to the 0 state.
        Reset(q1);
        Reset(q2);

        // Return the measurement results.
        return (m1, m2);
    }
}
```