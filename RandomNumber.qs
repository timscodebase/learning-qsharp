namespace EntanglementDemo {
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;

    @EntryPoint()
    operation Main() : (Result, Result) {
        // Original entanglement demo
        use (q1, q2) = (Qubit(), Qubit());
        H(q1);
        CNOT(q1, q2);
        DumpMachine();
        let (m1, m2) = (M(q1), M(q2));
        Reset(q1);
        Reset(q2);

        // Adding random number generation
        let max = 100;
        Message($"Sampling a random number between 0 and {max}: ");
        let randomNumber = GenerateRandomNumberInRange(max);
        Message($"Generated random number: {randomNumber}");

        // Return the entanglement results
        return (m1, m2);
    }

    operation GenerateRandomNumberInRange(max : Int) : Int {
        mutable bits = [];
        let nBits = BitSizeI(max);
        for idxBit in 1..nBits {
            set bits += [GenerateRandomBit()];
        }
        let sample = ResultArrayAsInt(bits);
        return sample > max ? GenerateRandomNumberInRange(max) | sample;
    }

    operation GenerateRandomBit() : Result {
        use q = Qubit();
        H(q);
        let result = M(q);
        Reset(q);
        return result;
    }
}