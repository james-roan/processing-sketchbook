/* James Roan
 * fishpond
 * 25 Sep 2019
 */
 
final color BG_COLOR = color(50,100,180);
final static int NUM_FISH = 10;
final static float GRAV_CONST = 0.01;

static Fish fish[];
static float deltaTime;
static int lastTime;
 
class Fish
{
  final static boolean DRAW_VECTORS = true;
  final static boolean REFLECT = true;
  
  color c;
  PVector pos;
  PVector vel;
  PVector accel;
  PVector force;
  float mass;
  float size;
  
  public Fish () {
     this.c = color(200);
     this.pos = new PVector(random(0,width), random(0,height));
     this.vel = new PVector();
     this.accel = new PVector();
     //this.force = new PVector();
     this.size = random(-15, 15);
     this.mass = 1;
  }
  
  public void draw () {
    pushMatrix();
    fill(c);
    translate(pos.x, pos.y);
    rotate(vel.heading());
    rect(0,0,20+size,20+size);
    popMatrix();
    if (DRAW_VECTORS) {
      pushStyle();
      stroke(175,60,60);
      strokeWeight(3);
      line(pos.x,pos.y,vel.x+pos.x,vel.y+pos.y);
      stroke(60,175,60);
      line(pos.x,pos.y,accel.x+pos.x,accel.y+pos.y);
      popStyle();
    }
    
  }
  
  /**
   * Calculate the next frame.
   * @param deltaTime The time in seconds since the last frame was diaplayed.
   * @return this, for chaining.
   */
  public Fish update(float deltaTime) {
    if (force != null) {
      accel.x = force.x/mass;
      accel.y = force.y/mass;
      force = null;
    }
    pos.x += vel.x * deltaTime;
    pos.y += vel.y * deltaTime;
    vel.x += accel.x * deltaTime;
    vel.y += accel.y * deltaTime;
    return this;
  }
  
  /**
   * Applies the desired force for the next update call.
   * Forces are applied for one frame, so the impulse varies based on deltaTime.
   * @return this, for chaining.
   */
  public Fish applyForce(PVector force) {
    this.force = force;
    return this;
  }
  
}
 
 void setup ()
 {
   size(1200, 1000);
   rectMode(CENTER);
   fish = new Fish[NUM_FISH];
   for(int i = 0; i<NUM_FISH; i++) {
     fish[i] = new Fish();
   }
 }
 
 
 void draw ()
 {
   deltaTime = (millis() - lastTime) / 1000f;
   background(BG_COLOR);
   for(Fish f : fish) {
     f.applyForce(getMouse().sub(f.pos));
     f.update(deltaTime).draw();
   }
   lastTime = millis();
 }
 
 PVector getMouse() { return new PVector(mouseX,mouseY); }

 
 
