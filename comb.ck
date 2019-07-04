/** Comb Filter. */
public class Comb {
  35::ms => dur delay;
  .88 => float feedback;

  fun UGen pass(UGen origin) {
    origin => Gain fb => DelayL comb;
    comb => Gain fbGain => fb;

    delay => comb.delay;
    feedback => fbGain.gain;

    return comb;
  }

  fun void set(dur tau, float g) {
    tau => delay;
    g => feedback;
  }
}
