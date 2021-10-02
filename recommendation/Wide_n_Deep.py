import pandas as pd
import numpy as np
import tensorflow as tf
import tempfile

def predict(path, file_name):
    df_tag = pd.read_csv(path + file_name, encoding='cp949')
    df_tag = pd.DataFrame(df_tag, columns=['tag'])
    list_tag = list(np.array(df_tag[0].tolist()))

    # Categorical base columns.
    unit = tf.contrib.layers.sparse_column_with_keys(column_name="unit", keys=["31사단", "53사단"])
    tag = tf.contrib.layers.sparse_column_with_keys(column_name="like_tag", keys=list_tag)
    # Continuous base columns.
    # ratings = tf.contrib.layers.real_valued_column("ratings")

    wide_columns = [
        unit, tag]
    deep_columns = [
        tf.contrib.layers.embedding_column(unit, dimension=8),
        tf.contrib.layers.embedding_column(tag, dimension=8)]

    # Define the column names for the data sets.
    COLUMNS = ["age", "workclass", "fnlwgt", "education", "education_num",
               "marital_status", "occupation", "relationship", "race", "gender",
               "capital_gain", "capital_loss", "hours_per_week", "native_country", "income_bracket"]
    LABEL_COLUMN = 'label'
    CATEGORICAL_COLUMNS = ["workclass", "education", "marital_status", "occupation",
                           "relationship", "race", "gender", "native_country"]
    CONTINUOUS_COLUMNS = ["age", "education_num", "capital_gain", "capital_loss",
                          "hours_per_week"]

    model_dir = tempfile.mkdtemp()
    m = tf.contrib.learn.DNNLinearCombinedClassifier(
        model_dir=model_dir,
        linear_feature_columns=wide_columns,
        dnn_feature_columns=deep_columns,
        dnn_hidden_units=[100, 50])

    # Read the training and test data sets into Pandas dataframe.
    df_train = pd.read_csv(train_file, names=COLUMNS, skipinitialspace=True)
    df_test = pd.read_csv(test_file, names=COLUMNS, skipinitialspace=True, skiprows=1)
    df_train[LABEL_COLUMN] = (df_train['income_bracket'].apply(lambda x: '>50K' in x)).astype(int)
    df_test[LABEL_COLUMN] = (df_test['income_bracket'].apply(lambda x: '>50K' in x)).astype(int)

    def input_fn(df):
        # Creates a dictionary mapping from each continuous feature column name (k) to
        # the values of that column stored in a constant Tensor.
        continuous_cols = {k: tf.constant(df[k].values)
                           for k in CONTINUOUS_COLUMNS}
        # Creates a dictionary mapping from each categorical feature column name (k)
        # to the values of that column stored in a tf.SparseTensor.
        categorical_cols = {k: tf.SparseTensor(
            indices=[[i, 0] for i in range(df[k].size)],
            values=df[k].values,
            shape=[df[k].size, 1])
            for k in CATEGORICAL_COLUMNS}
        # Merges the two dictionaries into one.
        feature_cols = dict(continuous_cols.items() + categorical_cols.items())
        # Converts the label column into a constant Tensor.
        label = tf.constant(df[LABEL_COLUMN].values)
        # Returns the feature columns and the label.
        return feature_cols, label

    def train_input_fn():
        return input_fn(df_train)

    def eval_input_fn():
        return input_fn(df_test)


    # 학습모델 평가
    m.fit(input_fn=train_input_fn, steps=200)
    results = m.evaluate(input_fn=eval_input_fn, steps=1)
    for key in sorted(results):
        print("%s: %s" % (key, results[key]))



def get_ratings(path, users_file_name):
    df_users = pd.read_csv(path + users_file_name, encoding='cp949')
    df_users_books = pd.DataFrame(df_users, columns=['user_id', 'like'])
    sr_users = []
    sr_books = []
    sr_ratings = []
    str_like = list(np.array(df_users_books['like'].tolist()))
    list_like = []
    for i in str_like:
        i = i.lstrip('[').rstrip(']')
        i = i.split(', ')
        list_like.append(i)

    for user_id in df_users_books['user_id']:
        for book_id in list_like[user_id]:
            sr_users.append(user_id)
            sr_books.append(book_id)
            sr_ratings.append(1)

    R = pd.DataFrame({
        'user_id': sr_users,
        'book_id': sr_books,
        'ratings': sr_ratings
    })

    R = R.pivot_table('ratings', index='user_id', columns='book_id').fillna(0)
    R.rename(columns= lambda x: int(x), inplace=True)
    R = R.sort_index(axis=1)
    return R

file_path = 'C:/Users/admin/Documents/osam_ai/book_dataset/'
users_file_name = "rec_user_1.csv"
books_file_name = "rec_books_1.csv"
pred_file_name = "rec_pred_score_1.csv"

predict(file_path, users_file_name, pred_file_name)

