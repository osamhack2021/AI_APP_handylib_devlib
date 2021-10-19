import pandas as pd
import numpy as np

def get_ratings(path, users_file_name, books_file_name):
    df_users = pd.read_csv(path + users_file_name, encoding='UTF8')
    df_books = pd.read_csv(path + books_file_name, encoding='UTF8')
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

    for user_idx in df_users_books['user_id']:
        for book_idx in list_like[user_idx]:
            if book_idx == '':
                break
            sr_users.append(user_idx)
            sr_books.append(book_idx)
            sr_ratings.append(1)

    for book_idx in range(len(df_books)):
        if sr_users[0]:
            sr_users.append(sr_users[0])
        if sr_books[0]:
            sr_books.append(book_idx)
        if sr_ratings[0]:
            sr_ratings.append(0)
    R = pd.DataFrame({
        'user_idx': sr_users,
        'book_idx': sr_books,
        'ratings': sr_ratings
    })

    R = R.pivot_table('ratings', index='user_idx', columns='book_idx').fillna(0)
    R.rename(columns= lambda x: int(x), inplace=True)
    R = R.sort_index(axis=1)
    return R

def loss_function(C, P, xTy, X, Y, r_lambda):
    predict_error = np.square(P-xTy)
    confidence_error = np.sum(C*predict_error)
    regularization = r_lambda * (np.sum(np.square(X)) + np.sum(np.square(Y)))
    total_loss = confidence_error + regularization
    return np.sum(predict_error), confidence_error, regularization, total_loss
def optimize_user(X, Y, C, P, nu, nf, r_lambda):
    yT = np.transpose(Y)
    for u in range(nu):
        Cu = np.diag(C[u])
        yT_Cu_y = np.matmul(np.matmul(yT, Cu), Y)
        lI = np.dot(r_lambda, np.identity(nf))
        yT_Cu_pu = np.matmul(np.matmul(yT, Cu), P[u])
        X[u] = np.linalg.solve(yT_Cu_y + lI, yT_Cu_pu)
def optimize_item(X, Y, C, P, ni, nf, r_lambda):
    xT = np.transpose(X)
    for i in range(ni):
        Ci = np.diag(C[:, i])
        xT_Ci_x = np.matmul(np.matmul(xT, Ci), X)
        lI = np.dot(r_lambda, np.identity(nf))
        xT_Ci_pi = np.matmul(np.matmul(xT, Ci), P[:, i])
        Y[i] = np.linalg.solve(xT_Ci_x + lI, xT_Ci_pi)
def predict(file_path, users_file_name, pred_score_file_name):
    R = get_ratings(file_path, users_file_name)

    r_lambda = 40
    nf = 200  # dimension of latent vector
    alpha = 40

    nu = R.shape[0]  # num of users
    ni = R.shape[1]  # num of items(books)

    X = np.random.rand(nu, nf) * 0.01
    Y = np.random.rand(ni, nf) * 0.01

    R = np.copy(R)
    P = np.copy(R)
    P[P > 0] = 1
    C = 1 + alpha * R

    predict_errors = []
    confidence_errors = []
    regularization_list = []
    total_losses = []

    for i in range(6):
        if i != 0:
            optimize_user(X, Y, C, P, nu, nf, r_lambda)
            optimize_item(X, Y, C, P, ni, nf, r_lambda)
        predict = np.matmul(X, np.transpose(Y))
        predict_error, confidence_error, regularization, total_loss = loss_function(C, P, predict, X, Y, r_lambda)

        predict_errors.append(predict_error)
        confidence_errors.append(confidence_error)
        regularization_list.append(regularization)
        total_losses.append(total_loss)

        #print('-----------step %d------------' % i)
        #print("predict error: %f" % predict_error)
        #print("confidence error: %f" % confidence_error)
        #print("regularization: %f" % regularization)
        #print("total_loss: %f" % total_loss)

    predict = np.matmul(X, np.transpose(Y))
    #print('final predict')
    #print(predict)

    df_predict = pd.DataFrame(predict, columns=range(len(R[0]))).fillna(0)  # user-item = 1400 x 1125
    df_predict.to_csv(file_path + pred_score_file_name)
