try:
    from importlib import metadata
except ImportError:
    import importlib_metadata as metadata

version = metadata.version("plotnine_examples")
