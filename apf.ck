/** All-pass Filter. */
public class APF {
  5::ms => dur delay;
  .7 => float gain;

  fun UGen pass(UGen origin) {
    origin => Gain fb => DelayL apf => Gain mix;
    apf => Gain fbGain => fb;
    fb => Gain mixGain => mix;

    delay => apf.delay;
    gain => fbGain.gain;
    -gain => mixGain.gain;

    return mix;
  }

  fun void set(dur tau, float g) {
    tau => delay;
    g => gain;
  }
}
