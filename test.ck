/* requires comb, apf, schroeder */

SchroederRev rev;
.1 => rev.mix;
50::ms => rev.preDelay;
1200::ms => rev.decay;

TriOsc triOsc => ADSR adsr => rev.pass => dac;

adsr.set(1::ms, 300::ms, 0., 1::ms);
.6 => triOsc.gain;

while (true) {
  Math.random2(36, 83) => Std.mtof => triOsc.freq;

  adsr.keyOn();
  900::ms => now;
  adsr.keyOff();
  100::ms => now;
}

