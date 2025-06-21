import kagglehub
from kagglehub import KaggleDatasetAdapter

file_path = "Phishing_Email.csv"

dataset = kagglehub.load_dataset(
  KaggleDatasetAdapter.PANDAS,
  "subhajournal/phishingemails",
  file_path,
)

dataset = dataset.dropna()

dataset['Email Type'] = dataset['Email Type'].replace({
    'Safe Email': 0,
    'Phishing Email': 1
})

data = dataset.sample(frac=0.95, random_state=786)
data_unseen = dataset.drop(data.index)
data = data.reset_index(drop=True)
data_unseen = data_unseen.reset_index(drop=True)

from pycaret.classification import *

exp = setup(
    data=data,
    target='Email Type',                
    text_features=['Email Text'], 
    session_id=42,
)

best_model = compare_models()

