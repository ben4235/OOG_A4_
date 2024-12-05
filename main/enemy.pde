class Enemy {
  //position of enemy
  PVector position;      
  //direction and speed of movement
  PVector velocity;      
  //enemy size
  float size = 30;       
  //enemy health
  int health = 10;       
  //enemy movement speed
  float speed = 1;       
  //position of player
  PVector playerPos;

  //constructor for spawning enemies off-screen
  Enemy() {
    if (random(1) > 0.5) {
      //spawn on one side of screen
      position = new PVector(random(-size, 0), random(-size, 0));
    } else {
      //spawn on the other side of the screen
      position = new PVector(random(width, width + size), random(-size, 0));
    }
    //initialize player position
    playerPos = new PVector(width / 2, height / 2);
    //enemy has no velocity starting out
    velocity = new PVector(0, 0);
  }

  //display the enemy
  void display() {
    //enemy is red
    fill(255, 0, 0);
    //enemy is circle for now
    ellipse(position.x, position.y, size, size);
  }

  //update the player's position for the enemy movement direction
  void updatePlayerPos(float px, float py) {
    //update the players position
    playerPos.set(px, py);
  }

  //move the enemy towards the player using PVector
  void move() {
    //vector from enemy to player
    PVector direction = PVector.sub(playerPos, position);
    //normalize the direction to get a unit vector
    direction.normalize();
    //scale the direction by speed
    direction.mult(speed);
    
    //update the enemy positio by adding the velocity
    position.add(direction);
  }

  //check if the enemy has been hit by a bullet
  boolean checkHit(Bullet b) {
    float distance = dist(position.x, position.y, b.x, b.y);
    if (distance < size / 2 + b.size / 2) {
      //decrease the health if hit
      health -= 5; 
      //bullet hit the enemy
      return true;
    }
    return false;
  }

  //check to see if the enemy is still alive
  boolean isAlive() {
    return health > 0;
  }
}
