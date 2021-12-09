import pandas as pd
pd.option_context('display.max_rows', None, 'display.max_columns', None)
import dash
from dash import dcc
from dash import html
import scipy
import plotly.express as px
from plotly import figure_factory as ff
import csv
import os
import pathlib as path
import plotly #https://plotly.com/python/getting-started/ /////// pip install plotly


toplaner_agg = path.Path(r'F:\LeagueStats\scraping\LeagueDataAnalysis\workingTables\TopLaneStats_agg_50games_majorLeague.csv')
toplaner_agg_winloss =  path.Path(r'F:\LeagueStats\scraping\LeagueDataAnalysis\workingTables\TopLaneStats_agg_Win-Loss_majorLeague.csv')
df_ta = pd.read_csv(toplaner_agg)
df_wl = pd.read_csv(toplaner_agg_winloss)
print(df_ta.columns)


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
    'background': '#111111',
    'text': '#7FDBFF'
}

pc = ['orange' if i == 'Solo' else 'blue' for i in df_ta['player']]
colorscale = [[1,'green'], [2, 'blue']]

#fig = px.scatter(df_ta, x='avg(earnedgoldshare)',y='winPercentage', size='games', hover_data=['player'], 
#            color= pc
#             )
fig = ff.create_distplot([df_ta['avg(damageshare)']], ['avg(damageshare)'])


fig.update_layout(
    plot_bgcolor=colors['background'],
    paper_bgcolor=colors['background'],
    font_color=colors['text']
)

app.layout = html.Div(children=[
    html.H1(children='Aggregate Toplaner By Win rate'),
    html.Div(children='''Hello Dash''
        Dash: A web application framework for your data.
    '''),

    dcc.Graph(
        id='Graph 1',
        figure=fig
    )
])

if __name__ == '__main__':
    app.run_server(debug=True)