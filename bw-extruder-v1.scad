

mxy=42; //motor xy
msxy=31; //motor screw xy
msd=3; //motor screw diameter
msh=21; //motor screw height
mhubd=22.5; // motor hub diameter
mhubh=2.7; //motor hub height

ss=1.3; //screw hole slop
stp=0.9; // screw thread percent

gd=8; //gear diameter
gh=15; //gear height this is 14, but adding 1mm for extra space
gad=3; // gear axel diamter
gah=20; // gear axel height
gfo=3;
ty=mxy/2-gd/2; //top y
tshx=mxy/2-mhubd/2; //top spring holder x
tz=12; //top z
tshz=tz-mhubh; //top spring holder z

by=20;
bz=mxy/2-((gd/2)*1.5);
bx=mxy;

hx=20; // handle thickness
hy=70; // handle length
hfd=3;
hgab=2; //handle gear axel border
fhd=3; // filament hole diameter
hz=mxy/2+gad/2+hgab;
springd=8;
springdepth=4;
springoffset=mxy-(mxy-(msxy+msd));

jheadod=16;
jheadsd=12;
jheadh=3.6;
jhsx=2.5;
jhsy=10;
jhsd=3;
jhsh=13;

ftd=4; //filament tube diameter
fmd=10; //filament motor distance(filament center to motor

fthd=7; //filament tube holder diameter

spacerd=10;
spacerh=5;

pt=5; //plate thickness


module extruder_handle(){
    difference(){
        cube([hx,hy,hz]);
       //gear hole
        translate([(hx-gh)/2,mxy/2-gd,mxy/2]){
            rotate([0,90,0]){
                cylinder(d=gd*1.5,h=gh);
            }
        }
        //gear axel hole
        translate([0,mxy/2-gd,mxy/2]){
            rotate([0,90,0]){
                cylinder(d=gad,h=gah,$fn=10);
            }
        }
        // clear handle
        translate([-1,(mxy/2)-(gd-(gad/2))+hgab,mxy/2-mhubd/2]){
            cube([hx+2,hy-(mxy/2)+gd-(gad/2)-hgab,hz-(mxy/2-mhubd/2)]);
        }
        //filament
        translate([hx-(hx/2-gh/2+3),mxy/2-gd/2,-1]){
            cylinder(d=fhd,h=hy+2,$fn=30);
        }
        //screw hole
        translate([-1,mxy/2-msxy/2,mxy/2-msxy/2]){
            rotate([0,90,0]){
                cylinder(d=msd*ss,h=hx+2,$fn=30);
            }
        }
        //spring detent
        translate([hx/2,springoffset,mxy/2-mhubd/2-springdepth]){
            cylinder(d=springd,h=springdepth+1,$fn=30);
        }
    }
}
module extruder_top(){
    difference(){
        translate([0,mxy-ty,0]){
            cube([mxy,ty,tz]);
        }
        //remove hub
        translate([mxy/2,mxy/2,0]){
            cylinder(d=mhubd,h=mhubh,$fn=90);
        }
        //top left screw
        translate([mxy/2-msxy/2,mxy/2+msxy/2,0]){
            cylinder(d=msd*ss,h=msh,$fn=30);
        }
        //top right screw
        translate([mxy/2+msxy/2,mxy/2+msxy/2,0]){
            cylinder(d=msd*ss,h=msh,$fn=30);
        }
        //remove majority of top
        translate([0,mxy-ty,mhubh]){
            cube([mxy-tshx,ty,tz]);
        }
    }
}
module extruder_bottom(){
    difference(){
        cube([bx,by,bz]);
        //remove hub
        translate([mxy/2,mxy/2,bz-mhubh]){
            rotate([90,0,0]){
                cylinder(d=mhubd,h=mhubh,$fn=90);
            }
        }
        //bottom motor left screw
        translate([mxy/2-msxy/2,-1,mxy/2-msxy/2]){
            rotate([-90,0,0]){
                cylinder(d=msd*ss,h=by+2,$fn=30);
            }
        }
        //bottom motor right screw
        translate([mxy/2+msxy/2,-1,mxy/2-msxy/2]){
            rotate([-90,0,0]){
                cylinder(d=msd*ss,h=by+2,$fn=30);
            }
        }
        //remove jhead
        translate([mxy/2-gd/2,fmd,-0.01]){
            cylinder(d=jheadod*1.01,h=jheadh,$fn=120);
        }
        //remove jhead tube holder
        translate([mxy/2-gd/2,fmd,-0.01]){
            cylinder(d=fthd,h=jheadh+3,$fn=120);
        }
        //remove jhead tube
        translate([mxy/2-gd/2,fmd,-0.01]){
            cylinder(d=ftd,h=bz+2,$fn=120);
        }
        //spring detent
        translate([springoffset,by/2-spacerh,bz-springdepth+1]){
            cylinder(d=springd,h=springdepth,$fn=30);
        }
        //bottom jhead left screw
        translate([jhsx,jhsy,-0.01]){
                cylinder(d=jhsd*stp,h=jhsh,$fn=30);
        }
        //bottom jhead right screw
        translate([bx-jhsx,jhsy,-0.01]){
                cylinder(d=jhsd*stp,h=jhsh,$fn=30);
        }
    }
}
module extruder_spacer(){
    difference(){
        cylinder(d=spacerd,h=spacerh,$fn=30);
        cylinder(d=msd*ss,h=spacerh+2,$fn=30);
    }
}
module extruder_jheadplate(){
    difference(){
        //main plate
        cube([bx,by,pt]);
        //jhead
        translate([mxy/2-gd/2,fmd,-0.01]){
            cylinder(d=jheadsd,h=pt+1,$fn=120);
        }
        //slideway
        translate([mxy/2-gd/2-jheadsd/2,-0.01,-0.01]){
            cube([jheadsd,by/2,pt+1]);
        }
        //bottom jhead left screw
        translate([jhsx,jhsy,-0.01]){
                cylinder(d=jhsd*ss,h=jhsh,$fn=30);
        }
        //bottom jhead right screw
        translate([bx-jhsx,jhsy,-0.01]){
                cylinder(d=jhsd*ss,h=jhsh,$fn=30);
        }
    }
}

//extruder_top();
//extruder_handle();
//rotate([90,0,0]){extruder_bottom();}
extruder_jheadplate();
//extruder_spacer();
