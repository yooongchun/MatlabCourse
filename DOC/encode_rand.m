function [James_coded_message,lower_limit,upper_limit] = encode_rand(original_message,coding_integer)
%
%The function encode_rand.m codes the text in the original_message by 
%converting it into a numerical matrix of the same size, but trasposed.
%
%This function has two input arguments.
%The first one is the text message itself in the form of a character array.
%The second one is an integer number which is used to encode the message
%and must be known to the intended recipient of the message.
%
%There are three output arguments
%The first one is the coded message in the form of a numerical matrix
%The second and the third output arguments (i.e. lower_limit and upper_limit) 
%are used to generate uniformly distributed random numbers in the range 
%[lower_limit, upper_limit]. 
%Both lower_limit and upper_limit must be known to the intended 
%recipient of the message so that he can decode the message.

%Convert the text message into an array of integer numbers
associated_array 	= double(original_message);

new_array        	= associated_array.^(pi);

%Determine the smallest and largest values of new_array
min_new_array    	= min(min(new_array));

max_new_array	= max(max(new_array));

%Calculate the difference between max_new_array and min_new_array after 
%rounding them to their nearest integer numbers
lower_limit      	= round(min_new_array);
upper_limit      	= round(max_new_array);
difference        	= upper_limit - lower_limit;

%Simulate equally probable random numbers between lower_limit and upper_limit
rng(coding_integer)
random_numbers	= lower_limit + difference*rand(size(original_message));

%Add the simulated random numbers to new_array and transpose the results
converted_array  	= new_array + random_numbers;
James_coded_message  	= converted_array';
