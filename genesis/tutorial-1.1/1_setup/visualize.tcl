##### read structure and coordinates
mol load psf ionize.psf pdb ionize.pdb

#### delete initial line representation for everything
mol delrep 0 top

#### make VDW representation for ions
mol representation VDW 1.000000 12.00000
mol color Name
mol selection {ions}
mol material Opaque
mol addrep top

#### make Cartoon representation for protein
mol representation NewCartoon 0.300000 10.000000 4.100000 0
mol color Structure
mol selection {protein}
mol material Opaque
mol addrep top

#### make line representation for water
mol representation Lines
mol color Name
mol selection {water}
mol material Opaque
mol addrep top

#### turn off axes
axes location off

### set white background
color Display Background 8
