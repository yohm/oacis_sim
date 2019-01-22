##### read pdb and remove crystal waters
mol load pdb 4pti_edit.pdb

# set the origin to the center of mass
set all [atomselect top all]
set protein [atomselect top protein]
$all moveby [vecinvert [measure center $protein weight mass]]

# write pdb of protein
$protein writepdb 4pti_protein.pdb
mol delete all

##### generate psf by using the psfgen plugin
package require psfgen
resetpsf
topology top_all27_prot_lipid.rtf

segment BPTI {
 first nter
 last cter
 pdb 4pti_protein.pdb
}
patch DISU BPTI:5 BPTI:55
patch DISU BPTI:14 BPTI:38
patch DISU BPTI:30 BPTI:51
regenerate angles dihedrals

pdbalias atom ILE CD1 CD
coordpdb 4pti_protein.pdb BPTI

guesscoord

# write psf and pdb files of protein
writepsf protein.psf
writepdb protein.pdb

#####  solvate with TIP3P waters by using the solvate plugin
mol delete all
package require solvate
solvate protein.psf protein.pdb -rotate -t 22.5 -o solvate

#####  add counter ions by using the autoionize plugin
mol delete all
package require autoionize
autoionize -psf solvate.psf -pdb solvate.pdb -neutralize -cation SOD -anion CLA -seg ION -o ionize

#####  set the origin to the center of mass and check boxsize
set all [atomselect top all]
$all moveby [vecinvert [measure center $all weight mass]]
$all writepdb ionize.pdb

set minmax [measure minmax $all]
foreach {min max} $minmax { break }
foreach {xmin ymin zmin} $min { break }
foreach {xmax ymax zmax} $max { break }
puts "Box size estimation:"
puts "boxsizex = [expr abs($xmin)+ $xmax + 1.0]"
puts "boxsizey = [expr abs($ymin)+ $ymax + 1.0]"
puts "boxsizez = [expr abs($zmin)+ $zmax + 1.0]"

exit

