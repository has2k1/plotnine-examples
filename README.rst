#################
plotnine examples
#################

This repository contains examples in the form of jupyter notebooks
that are also part of the plotnine_ documentation.

**Rebase Notice**: When the repository gets large and the
will be reduced by deleting the history.

Contributing
============

1. Clone repository or pull in latest changes

   .. code-block:: console

      git clone https://github.com/has2k1/plotnine-examples

   Or

   .. code-block:: console

      cd plotnine-examples
      git pull

2. Create a notebook or edit an existing notebook. The name of the
   notebook should match the object. e.g if examples are for ``geom_tile``
   the name should be ``geom_tile.ipynb``.

3. Execute the notebook once, top to bottom OR preferably if you can (Linux/OSX)
   run ``make changes`` from the command line.

4. Add your github username and/or name to ``contributors.txt``
   (sorted according to the username) and commit.

5. Commit

6. Push

   .. code-block:: console

      git push

5. Submit Pull Request


How to structure a notebook
===========================
The plotnine `gallery`_ consists of images extracted from the examples.
For this to happen, each example in the file should have a ``### Title``
(h3 header) that serves as the title of the example. It should be followed
by a ``*Short Description*`` (emphasis) directly beneath. The last image of
each of these sections in is selected and put in the gallery. Avoid creating
``#`` or ``##`` sections.

See `geom_tile.ipynb <plotnine_examples/examples/geom_tile.ipynb>`_

.. _plotnine: https://github.com/has2k1/plotnine
.. _documentation: https://plotnine.readthedocs.io/en/latest/
.. _gallery: https://plotnine.readthedocs.io/en/latest/gallery.html
