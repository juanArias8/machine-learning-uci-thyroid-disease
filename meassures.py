# Algoritmos de medida de desempeño
def get_meassure(y_test, y_est):
    tp, fp, tn, fn = 0, 0, 0, 0
    for i in range(len(y_est)): 
        if y_test[i] == y_est[i] == 1:
            tp += 1
        if y_est[i] == 1 and y_test[i] == 0:
            fp += 1
        if y_test[i] == y_est[i] == 0:
            tn += 1
        if y_est[i] == 0 and y_test[i] == 1:
            fn += 1

    return(tp, fp, tn, fn)

def get_sensitive(tp, fn):
    return tp / (tp + fn) 

def get_specificity(tn, fp):
    return tn / (tn + fp)