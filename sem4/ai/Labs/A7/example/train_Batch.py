import torch

import myModel

x = torch.unsqueeze(torch.linspace(-1, 1, 100), dim=1)

# Creates a one-dimensional tensor of size 100 whose values are evenly spaced
# from -1 to 1, inclusive, and is placeing the values in a tensor like
# so x = [ [-1], [-0.98], ..., [0.98]. 1]

# print(x)

y = x.pow(2) + 0.2
# the function to be optimised

# print(y)


# we set up the lossFunction as the mean square error
lossFunction = torch.nn.MSELoss()

# we create the ANN
ann = myModel.Net(n_feature=1, n_hidden=10, n_output=1)

print(ann)
# we use an optimizer that implements stochastic gradient descent 
optimizer_batch = torch.optim.SGD(ann.parameters(), lr=0.2)

# we memorize the losses forsome graphics
loss_list = []
avg_loss_list = []

# we set up the environment for training in batches  
batch_size = 16
n_batches = int(len(x) / batch_size)
print(n_batches)

for epoch in range(2000):

    for batch in range(n_batches):
        # we prepare the current batch  -- please observe the slicing for tensors
        batch_X, batch_y = x[batch * batch_size:(batch + 1) * batch_size, ], y[batch * batch_size:(
                                                                                                              batch + 1) * batch_size, ]

        print(batch_X)
        print(batch_y)
        # we compute the output for this batch
        prediction = ann(batch_X)

        # we compute the loss for this batch
        loss = lossFunction(prediction, batch_y)

        # we save it for graphics
        loss_list.append(loss)

        # we set up the gradients for the weights to zero (important in pytorch)
        optimizer_batch.zero_grad()

        # we compute automatically the variation for each weight (and bias) of the network
        loss.backward()

        # we compute the new values for the weights
        optimizer_batch.step()

        # we print the loss for all the dataset for each 100th epoch
    if epoch % 100 == 99:
        y_pred = ann(x)
        loss = lossFunction(y_pred, y)
        print('\repoch: {}\tLoss =  {:.5f}'.format(epoch, loss))

    # Specify a path
filepath = "myNet.pt"

# save the model to file
torch.save(ann.state_dict(), filepath)

# visualise the parameters for the ann (aka weights and biases)
# for name, param in ann.named_parameters():
#     if param.requires_grad:
#         print (name, param.data)
