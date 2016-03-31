# coding: utf-8

import sys
from bopy.helpers.ezpadova import cmd
from astropy.table import Table


# download isochrones
assert len(sys.argv) == 3
my_isochrone = eval('cmd.get_one_isochrone(%s)' % sys.argv[1])

# write this table
assert isinstance(sys.argv[2], str) and sys.argv[2] != ''
Table(my_isochrone.data).write(sys.argv[2])


# my_isochrones = cmd.get_t_isochrones(
#     6.1, 8.0, 0.1, metal=0.0001,isoc_kind='parsec_CAF09_v1.2S', phot='2mass')
# r = cmd.get_one_isochrones(1e7, 0.02, model='parsec12s', phot='spitzer')

