function plot_test_attitude_sim(t,X)

    % Extract states and reference states
    mrpBN = X(1:3,:);
    BwBN = rad2deg(X(4:6,:));

    %% MRP Plot
    figure;

    subplot(4,1,1)
    plot(t, mrpBN(1,:), 'LineWidth', 2)
    ylabel('\sigma_{1}')
    title('Modified Rodrigues Parameters')
    grid on
    legend('\sigma_{B/N}')

    subplot(4,1,2)
    plot(t, mrpBN(2,:), 'LineWidth', 2)
    ylabel('\sigma_{2}')
    grid on
    legend('\sigma_{B/N}')

    subplot(4,1,3)
    plot(t, mrpBN(3,:), 'LineWidth', 2)
    ylabel('\sigma_{3}')
    grid on
    legend('\sigma_{B/N}')

    subplot(4,1,4)
    plot(t, vecnorm(mrpBN,2,1), 'LineWidth', 2)
    ylabel('|\sigma|')
    xlabel('Time [s]')
    grid on
    legend('\sigma_{B/N}')

    %% Angular Velocity Plot
    figure;

    subplot(3,1,1)
    plot(t, BwBN(1,:), 'LineWidth', 2)
    ylabel('^B\omega_{1} [deg/s]')
    title('Angular Velocity')
    grid on
    legend('\omega_{B/N}')

    subplot(3,1,2)
    plot(t, BwBN(2,:), 'LineWidth', 2)
    ylabel('^B\omega_{2} [deg/s]')
    grid on
    legend('\omega_{B/N}')

    subplot(3,1,3)
    plot(t, BwBN(3,:), 'LineWidth', 2)
    ylabel('^B\omega_{3} [deg/s]')
    xlabel('Time [s]')
    grid on
    legend('\omega_{B/N}')

end

