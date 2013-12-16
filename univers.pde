

ArrayList<atome> lesatomes;

float echelle=10.0;
float neoechelle;
int nb_bebe=5;

void setup() {
  size(800, 600);
  lesatomes=new ArrayList<atome>();

  lesatomes.add(new atome(0, 0));
  lesatomes.add(new atome(1, 1));
  lesatomes.add(new atome(-1, 0));
  lesatomes.add(new atome(1, 0));
  stroke(255);
}

void draw() {
  int maximum=0;
int creation=0;
  background(0);
  strokeWeight(echelle);
  translate(width/2, height/2);
  boolean bebe=false;
  for (int i=0;i< lesatomes.size();i++) {
    atome ta=lesatomes.get(i);
    ta.affiche();

    // info pour le zoom
    if (abs(ta.px) > maximum) {
      maximum=ta.px;
    }

    if (abs(ta.py) > maximum) {
      maximum=ta.py;
    }


    IntList nb_contact=ta.compte();
    if (nb_contact.size()==1 || nb_contact.size()>5) {
      lesatomes.remove(i);
    }
    if (nb_contact.size() > 3 && nb_contact.size() < 7 && creation<nb_bebe) {
      // prolifération
      int trouve=-1;
      creation++;
      while (trouve==-1) {
        int neo=int(random(9));
        if (!nb_contact.hasValue(neo)) {
          trouve=neo;
        }
      }
      if (trouve==0) { 
        lesatomes.add(new atome(ta.px-1, ta.py-1));
      }
      if (trouve==1) { 
        lesatomes.add(new atome(ta.px, ta.py-1));
      }
      if (trouve==2) { 
        lesatomes.add(new atome(ta.px+1, ta.py-1));
      }
      if (trouve==3) { 
        lesatomes.add(new atome(ta.px-1, ta.py));
      }
      if (trouve==5) { 
        lesatomes.add(new atome(ta.px+1, ta.py));
      }
      if (trouve==6) { 
        lesatomes.add(new atome(ta.px-1, ta.py+1));
      }
      if (trouve==7) { 
        lesatomes.add(new atome(ta.px, ta.py+1));
      }
      if (trouve==8) { 
        lesatomes.add(new atome(ta.px+1, ta.py+1));
      }
      println("resultat de l'ajout est "+trouve);
    }
  }

  echelle=height/(maximum*2);
  echelle=constrain(echelle,0.5,20);
  
}

void mouseClicked() {
  int px=int((mouseX/echelle)-((width/2)/echelle));
  int py=int((mouseY/echelle)-((height/2)/echelle));
  lesatomes.add(new atome(px, py));
  println(px+" "+py);
}

void keyPressed() {
  if (key==CODED) {
    if (keyCode==UP) {
      echelle*=1.1;
    } 
    else {
      if (keyCode==DOWN) {
        echelle*=0.9;
      }
    }
    echelle=constrain(echelle, 1, 40);
  }
}

class atome {
  int px, py;

  //constructeur
  atome(int px, int py) {
    this.px=px;
    this.py=py;
  }

  // méthodes
  void affiche() {
    point(px*echelle, py*echelle);
  }

  IntList compte() {
    IntList nb= new IntList();
    for (int i=0;i< lesatomes.size();i++) {
      atome ta=lesatomes.get(i);
      if (ta.px - px < 2  && ta.px - px > -2 && ta.py-py <2 && ta.py-py > -2) {
        nb.append(((py+1)*3) + ((px+1)*3));
      }
    }
    return nb;
  }
}
