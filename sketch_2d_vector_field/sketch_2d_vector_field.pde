/* James Roan
 * 21 Sep 2019
 * sketch_2d_vector_field.pde
 *
 * A basic 2d vector field visualizer
 */


static final int   MAX_POINTS     = 22500;
static final int   NUM_POINTS_X   = 50;
static final int   NUM_POINTS_Y   = 50;
static final float VECTOR_SCALE   = 50;
static final int   VECTOR_OPACITY = 230;
static final float VECTOR_WEIGHT  = 3;
static final float ANIMATION_RATE = 0.004;
static final float SIMULATION_OVERSIZE = 0.5;  // how far out of the viewport the vectors are allowed to remain alive
static final float CLICK_SPAWN_RANDOMNESS = 0.09;

class FieldNode extends PVector
{
  public color c;
  public FieldNode (float x, float y, color c) {
    super(x, y);
    this.c = c;
  }
  public FieldNode (FieldNode v) {
    super(v.x, v.y);
    this.c = v.c;
  }
}
static ArrayList<FieldNode> points = new ArrayList<FieldNode>();


final color[] PALETTE = {
  #bb1542,  // deep red
  #eb5f5d,  // light red
  #fabc74,  // orange/yellow
  #239f95   // blue
};


/* Frame independent timing */
static int deltaTime = 0;
static int endTime = 0;

/* Animation on/off */
static boolean animate = true;


void setup ()
{
  size(1200,900);
  strokeWeight(VECTOR_WEIGHT);
  frameRate(60);
  if (true) {
    spawn_random_vectors(NUM_POINTS_X*NUM_POINTS_Y);
  } else {
    float spacing_x = 2f/NUM_POINTS_X;
    float spacing_y = 2f/NUM_POINTS_Y;
    int point_num = 0;
    for (float i = -1; i < 1; i+=spacing_x) {
      for (float j = -1; j < 1; j+=spacing_y) {
        points.add(new FieldNode(i, j, PALETTE[point_num%PALETTE.length]));
        point_num++;
      }
    }
  }
  
}

void draw ()
{
  deltaTime = millis() - endTime;
  background(25,30,25);
  
  ArrayList<FieldNode> p_copy = new ArrayList<FieldNode>(points);
  for (FieldNode p : p_copy) {
    float pos_x = map(p.x, -1, 1, 0, width);
    float pos_y = map(p.y, -1, 1, 0, height);
    if (p.x > 1+SIMULATION_OVERSIZE || p.x < -1-SIMULATION_OVERSIZE || p.y > 1+SIMULATION_OVERSIZE || p.y < -1-SIMULATION_OVERSIZE) {
      points.remove(p);
      spawn_random_vectors(1);
    } else {
      stroke(p.c, VECTOR_OPACITY);
      line(pos_x, pos_y, pos_x+(VECTOR_SCALE*gradient_x(p, deltaTime)), pos_y+(VECTOR_SCALE*gradient_y(p, deltaTime)));
      if (animate) {
        p.x = step_x(p, deltaTime);
        p.y = step_y(p, deltaTime);
      }
    }
  }
  
  if (points.size() > MAX_POINTS) {
    while (points.size() > MAX_POINTS) {
      points.remove(int(random(0, points.size()-1)));
    }
  }
  
  endTime = millis();
}

// click to spawn vectors around the mouse
void mousePressed ()
{
  float px = map(mouseX, 0, width, -1, 1);
  float py = map(mouseY, 0, height, -1, 1);
  for (int i = 0; i < 10; i++) {
    spawn_vector(px, py, CLICK_SPAWN_RANDOMNESS, PALETTE[(millis()+i)%PALETTE.length]);
  }
}

// press spacebar to pause the animation
void keyPressed () {
  if (key == ' ')
    animate = !animate;
}

void spawn_random_vectors (int n) {
  for (int i=0; i < n; i++) {
    spawn_vector(0, 0, 1, PALETTE[millis()%PALETTE.length]);
  }
}

void spawn_vector (float x, float y, float variation, color c) {
  points.add(new FieldNode(x+random(-1*variation, variation), y+random(-1*variation, variation), c));
}

// Parametric gradient equation functions
float gradient_x (PVector p, float dt)
{
  return 0.3*sin(p.x)+0.6*sin(0.2*p.y);
}

float gradient_y (PVector p, float dt)
{
  return -0.4*sin(3*p.x);
}

// The animation steps move the point in the direction of the vector
// this could be more efficient by removing double calls to gradient_*()
float step_x (PVector p, float dt)
{
  return p.x+(gradient_x(p,dt)*ANIMATION_RATE*dt);
}

float step_y (PVector p, float dt)
{
  return p.y+(gradient_y(p,dt)*ANIMATION_RATE*dt);
}
