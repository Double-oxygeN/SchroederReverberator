/** Schroeder Reverbrator.
 ** requires comb, apf */

fun float calcGain(dur decay, dur combDelay) {
  (combDelay / decay) * -3 * Math.log(10) => Math.exp => float result;
  return -result;
}

public class SchroederRev {
  .1 => float mix;

  2::second => dur decay;
  0::ms => dur preDelay;

  fun UGen pass(UGen origin) {
    Gain rev;

    origin => Gain dry => rev;
    (1. - mix) => dry.gain;

    DelayL preDelayUnit => Gain wet => rev;
    mix => wet.gain;
    preDelay => preDelayUnit.delay;

    Comb combs[4];
    [1913::samp, 1733::samp, 1597::samp, 1447::samp] @=> dur combDelays[];

    Gain aggr;

    APF apf1;
    APF apf2;
    (5::ms, .7) => apf1.set;
    (1.7::ms, .7) => apf2.set;

    for (0 => int i; i < combs.cap(); i++) {
      combDelays[i] => dur tau;
      (tau, calcGain(decay, tau)) => combs[i].set;
      origin => combs[i].pass => aggr;
    }
    aggr => apf1.pass => apf2.pass => wet;

    return rev;
  }
}
