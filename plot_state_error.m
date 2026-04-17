function plot_state_error(t,Xe)
    
    % Extract states and reference states
    mrpBR = Xe(1:3,:);
    BwBR = rad2deg(Xe(4:6,:));

    %% MRP Error Plot
    figure;

    subplot(3,1,1)
    plot(t, mrpBR(1,:), 'LineWidth', 1.5)
    ylabel('\sigma_{1}')
    title('Modified Rodrigues Parameters Attitude Errors')
    grid on
    legend('\sigma_{B/R}')

    subplot(3,1,2)
    plot(t, mrpBR(2,:), 'LineWidth', 1.5)
    ylabel('\sigma_{2}')
    grid on
    legend('\sigma_{B/R}')

    subplot(3,1,3)
    plot(t, mrpBR(3,:), 'LineWidth', 1.5)
    ylabel('\sigma_{3}')
    grid on
    legend('\sigma_{B/R}')



    %% Angular Velocity Error Plot
    figure;

    subplot(3,1,1)
    plot(t, BwBR(1,:), 'LineWidth', 1.5)
    ylabel('^B\omega_{1} [deg/s]')
    title('Angular Velocity Errors')
    grid on
    legend('^B\omega_{B/R}')

    subplot(3,1,2)
    plot(t, BwBR(2,:), 'LineWidth', 1.5)
    ylabel('^B\omega_{2} [deg/s]')
    grid on
    legend('^B\omega_{B/R}')

    subplot(3,1,3)
    plot(t, BwBR(3,:), 'LineWidth', 1.5)
    ylabel('^B\omega_{3} [deg/s]')
    xlabel('Time [s]')
    grid on
    legend('^B\omega_{B/R}')


end

