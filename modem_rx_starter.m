
load long_modem_rx.mat

% The received signal includes a bunch of samples from before the
% transmission started so we need discard these samples that occurred before
% the transmission started. 

start_idx = find_start_of_signal(y_r,x_sync);
% start_idx now contains the location in y_r where x_sync begins
% we need to offset by the length of x_sync to only include the signal
% we are interested in
y_t = y_r(start_idx+length(x_sync):end); % y_t is the signal which starts at the beginning of the transmission


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Put your decoder code here
%%
% Low Pass Filter
c = cos(2*pi*f_c/Fs*[0:length(y_r)-1]');

plot_ft_rad(y_r, Fs);
conv_cos = conv(y_r,c);
plot_ft_rad(conv_cos, Fs);

plot_ft_rad(y_r, Fs);
W = 2*pi*500;
h = W/pi*sinc(W/pi*length(y_r));
sinc_conv = conv(y_r, h);
plot_ft_rad(sinc_conv, Fs);
plot(sinc_conv)
soundsc(sinc_conv, Fs);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% convert to a string assuming that x_d is a vector of 1s and 0s
% representing the decoded bits
BitsToString(x_d)

