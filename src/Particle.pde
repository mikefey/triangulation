class Particle {

    PVector location;
    PVector velocity;
    PVector acceleration;
    float mass = .5;
    float angle = 0;
    float aVelocity = 0;
    float aAcceleration = 0;
    toxi.physics2d.VerletParticle2D tlParticle;
    int iteration;

    Particle(PVector loc, int it) {
        tlParticle = new toxi.physics2d.VerletParticle2D(loc);
        iteration = it;
    }

    void update() {

    }

    void display() {
        fill(0, 0, 0);
        pushMatrix();
        translate(tlParticle.x, tlParticle.y);
        ellipse(0, 0, mass * 32, mass * 32);
        popMatrix();
    }

}