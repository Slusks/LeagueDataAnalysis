import pandas as pd
pd.set_option('display.max_rows', 200)
pd.set_option("display.max_columns", None)
pd.option_context('display.max_rows', None, 'display.max_columns', None)
import dash
from dash import dcc
from dash import html
import plotly.express as px
from plotly import figure_factory as ff
from plotly.subplots import make_subplots
import pathlib as path
import numpy as np
import scipy



toplaner_agg = path.Path(r'F:\LeagueStats\scraping\LeagueDataAnalysis\workingTables\TopLaneStats_agg_50games_majorLeague.csv')
toplaner_agg_winloss =  path.Path(r'F:\LeagueStats\scraping\LeagueDataAnalysis\workingTables\TopLaneStats_agg_Win-Loss_majorLeague.csv')
df_ta = pd.read_csv(toplaner_agg)
df_wl = pd.read_csv(toplaner_agg_winloss)

###### Calculations and table generation functions #####
dft = df_wl[['player', 'games','result', 'avg(earnedgoldshare)']]
tat = df_ta[['player','winPercentage']]
dft2 = dft.merge(tat, on='player')

def func(result, winPercentage):
    if result == 0:
        return 100-winPercentage
    else:
        return winPercentage



dft2['winPercentage'] = dft2.apply(lambda x: func(x['result'], x['winPercentage']), axis=1)
dft2.reset_index(drop=True, inplace=True)
########################################################



def generate_table(dataframe, max_rows=10):
    return html.Table([
        html.Thead(
            html.Tr([html.Th(col) for col in dataframe.columns])
        ),
        html.Tbody([
            html.Tr([
                html.Td(dataframe.iloc[i][col]) for col in dataframe.columns
            ]) for i in range(min(len(dataframe), max_rows))
        ])
    ])

app = dash.Dash(__name__)
colors = {
    'background': '#161414',
    'text': '#7FDBFF'
}

pc = ['orange' if i == 'Solo' else 'light blue' for i in dft2['player']]
def player_color():
    d = {}
    for player in dft2['player']:
        d.update({player: 'light blue'})
    d['Solo'] = 'orange'
    return d


mymean = np.mean(dft2['avg(earnedgoldshare)'])
mystd = np.std(dft2['avg(earnedgoldshare)'])
mypd = scipy.stats.norm.pdf((dft2['avg(earnedgoldshare)']), mymean, mystd)
mult = [-3,-2,-1,0,1,2,3]
distribution = np.linspace(mymean - 3*mystd, mymean + 3*mystd, 185)
stdvals = [((i*mystd)+mymean).round(3) for i in mult]



winners = dft2.loc[dft2['result']==1]['avg(earnedgoldshare)']
losers = dft2.loc[dft2['result']==0]['avg(earnedgoldshare)']
text = list(dft2.player)
hist_data = [winners.round(4), losers.round(4)]
group_labels = ['Won', 'Lost']
chart_colors = ['purple', 'orange']

counts, bins = np.histogram(winners)
fig = ff.create_distplot(hist_data, 
                        group_labels, 
                        bin_size = 0.0009, 
                        colors = chart_colors,
                        curve_type='normal',
                        show_rug=False 
                        )

fig2 = px.scatter(x="avg(earnedgoldshare)",
                    y='winPercentage',
                    data_frame=dft2,
                    color = pc,#color_discrete_map=pc,
                    hover_data=['player'],
                    trendline="ols",
                    facet_col="result",
                    trendline_color_override="green")
#//color_discrete_map=player_color()//

fig.update_layout(bargap=0.02,
                title_text = 'Avg Earned Gold Share By Result')


fig.update_layout(
    plot_bgcolor=colors['background'],
    paper_bgcolor=colors['background'],
    font_color=colors['text']
)

fig2.update_layout(
    plot_bgcolor=colors['background'],
    paper_bgcolor=colors['background'],
    font_color=colors['text']
)

app.layout = html.Div(children=[
    html.H1(children='Aggregate Toplaner By Win rate'),
    html.Div(children='''Samsite
        Application developed using Dash
    '''),

    dcc.Graph(
        id='Graph 1',
        figure=fig
    ),
    dcc.Graph(
        id='Graph 2',
        figure=fig2
    )
])

if __name__ == '__main__':
    app.run_server(debug=True)