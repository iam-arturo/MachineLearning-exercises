%% Machine Learning Online Class
%  Exercise 1: Linear regression with multiple variables
%
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear regression exercise. 
%
%  You will need to complete the following functions in this 
%  exericse:
%
%     warmUpExercise.m
%     plotData.m
%     gradientDescent.m
%     computeCost.m
%     gradientDescentMulti.m
%     computeCostMulti.m
%     featureNormalize.m
%     normalEqn.m
%
%  For this part of the exercise, you will need to change some
%  parts of the code below for various experiments (e.g., changing
%  learning rates).
%

%% Initialization

%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
data = load('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% Print out some data points
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];


%% ================ Part 2: Gradient Descent ================

% ====================== YOUR CODE HERE ======================
% Instructions: We have provided you with the following starter
%               code that runs gradient descent with a particular
%               learning rate (alpha). 
%
%               Your task is to first make sure that your functions - 
%               computeCost and gradientDescent already work with 
%               this starter code and support multiple variables.
%
%               After that, try running gradient descent with 
%               different values of alpha and see which one gives
%               you the best result.
%
%               Finally, you should complete the code at the end
%               to predict the price of a 1650 sq-ft, 3 br house.
%
% Hint: By using the 'hold on' command, you can plot multiple
%       graphs on the same figure.
%
% Hint: At prediction, make sure you do the same feature normalization.
%

fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha = 0.01;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(3, 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================
% Recall that the first column of X is all-ones. Thus, it does
% not need to be normalized.
%price = 0; % You should change this

X_example = [1; (1650-mu(1))/sigma(1); (3-mu(2))/sigma(2)];

price = X_example' * theta;

% ============================================================

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using gradient descent):\n $%f\n'], price);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ======= Part 2.5:Trying p different alphas ============


alphas = [0.003; alpha ; 0.03 ; 0.1 ; 0.3 ; 1];
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(3, 6);

[theta(:,1), J1] = gradientDescentMulti(X, y, theta(:,1), alphas(1), num_iters);
[theta(:,2), J2] = gradientDescentMulti(X, y, theta(:,2), alphas(2), num_iters);
[theta(:,3), J3] = gradientDescentMulti(X, y, theta(:,3), alphas(3), num_iters);
[theta(:,4), J4] = gradientDescentMulti(X, y, theta(:,4), alphas(4), num_iters);
[theta(:,5), J5] = gradientDescentMulti(X, y, theta(:,5), alphas(5), num_iters);
[theta(:,6), J6] = gradientDescentMulti(X, y, theta(:,6), alphas(6), num_iters);


% Plot the convergence graph
figure;
plot(1:num_iters, J1, '-b', 'LineWidth', 2);
hold on;
plot(1:num_iters, J2, '-r', 'LineWidth', 2);
plot(1:num_iters, J3, '-k', 'LineWidth', 2);
plot(1:num_iters, J4, '-b', 'LineWidth', 2);
plot(1:num_iters, J5, '-r', 'LineWidth', 2);
plot(1:num_iters, J6, '-k', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');
legend('1st alpha', '2nd alpha', '3rd alpha', '4th alpha', '5th alpha', '6th alpha')


% ============================================================


%% ================ Part 3: Normal Equations ================

fprintf('Solving with normal equations...\n');

% ====================== YOUR CODE HERE ======================
% Instructions: The following code computes the closed form 
%               solution for linear regression using the normal
%               equations. You should complete the code in 
%               normalEqn.m
%
%               After doing so, you should complete this code 
%               to predict the price of a 1650 sq-ft, 3 br house.
%

%% Load Data
data = csvread('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% Add intercept term to X
X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
theta = normalEqn(X, y);

% Display normal equation's result
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');


% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================
%price = 0; % You should change this

X_example = [1 1650 3]; %1x3
%theta is a 3x1 now using normalEqn, not 1x3 as before.
price = X_example * theta;

% ============================================================

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using normal equations):\n $%f\n'], price);

