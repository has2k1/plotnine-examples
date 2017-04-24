##############
How to release
##############

1. Execute the notebooks
   ::

       make notebooks

2. Bump up version in `setup.py`
   ::

       __version__ = '0.0.1'

3. Release
   ::

       make release
