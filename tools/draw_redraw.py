
def draw_redraw(p, fig, axs):
    if fig is None:
        # If this is the first time a plot is made in the notebook, we let plotnine create a new
        # matplotlib figure and axis.
        fig, plot = p.draw(return_ggplot=True)
        axs = plot.axs
    else:

        #p = copy(p)
        # This helps keeping old selected data from being visualized after a new selection is made.
        # We delete all previously created artists from the matplotlib axis.
        for artist in plt.gca().lines +\
                        plt.gca().collections +\
                        plt.gca().artists + plt.gca().patches + plt.gca().texts:
            artist.remove()

        # If a plot is being updated, we re-use the figure and axis created before.
        p._draw_using_figure(fig, axs)
    return fig, axs
