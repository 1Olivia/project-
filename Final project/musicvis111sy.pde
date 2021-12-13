import ddf.minim.*;
Minim minim;
import ddf.minim.ugens.*;
AudioOutput out;
float hue=0;
void setup() {
  size(660, 1000);
  minim = new Minim(this);
  out = minim.getLineOut( Minim.MONO, 2048 );
  colorMode(HSB, 360, 100, 100);
  textAlign(CENTER, CENTER);
  background(#FFFFFF);
  strokeWeight(4);
}

void draw() {
  noStroke();
  fill(#FFFFFF, 10);
  rect(0, 0, width, height);
  float size=random(20, 100);
  for (int i=0; i<2; i++)
  {
    stroke(0);
    fill(random(hue-30, hue+30), 100, 100);
    ellipse(random(width), random(140, height-190), size, size);
  }


  fill(#FFFFFF);
  rect(0, 886, width, 400);

  fill(#FFFFFF);
  rect(0, 0, width, 130);

  fill(#FFFFFF);

  for (int i = 0; i <out.bufferSize() - 1; i++)
  {
    strokeWeight(4);
    noFill();
    float x1 = map(i, 0, out.bufferSize(), 0, width);
    float x2 = map(i+1, 0, out.bufferSize(), 0, width);
    float hues=map(i, 0, out.bufferSize(), hue, hue+60);
    stroke(hues, 100, 100, 100);
    line(x1, 60 -out.mix.get(i)*60, x2, 60- out.mix.get(i+1)*60);
    line(x1, height-60-out.mix.get(i)*60, x2, height-60-out.mix.get(i+1)*60);
  }

  stroke(0);

  float h=map(noise(frameCount/10), 0, 1, -50, 50);
  fill(hue+h, 100, 100);
  float s=map(noise(frameCount/10), 0, 1, 10, 110);
  ellipse(mouseX, mouseY, s, s);
}
void keyPressed()
{
}
void mousePressed()
{
  hue=map(mouseX, 0, width, 0, 360);
  out.playNote(0, 0.3, new ToneInstrument(mouseX*5, 1.57 ) );
  out.resumeNotes();
}
