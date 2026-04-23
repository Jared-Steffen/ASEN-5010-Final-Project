function plot_test_control(t,X,Xr,u)

    % Extract states and reference states
    mrpBN = X(1:3,:);
    BwBN = rad2deg(X(4:6,:));
    mrpRN = Xr(1:3,:);
    BwRN = rad2deg(Xr(4:6,:));

    %% MRP Plot
    figure;

    subplot(4,1,1)
    plot(t, mrpBN(1,:), 'LineWidth', 2)
    hold on
    plot(t, mrpRN(1,:),'--', 'LineWidth', 2)
    ylabel('\sigma_{1}')
    title('Modified Rodrigues Parameters')
    grid on
    legend('\sigma_{B/N}','\sigma_{R/N}')

    subplot(4,1,2)
    plot(t, mrpBN(2,:), 'LineWidth', 2)
    hold on
    plot(t, mrpRN(2,:),'--', 'LineWidth', 2)
    ylabel('\sigma_{2}')
    grid on
    legend('\sigma_{B/N}','\sigma_{R/N}')

    subplot(4,1,3)
    plot(t, mrpBN(3,:), 'LineWidth', 2)
    hold on
    plot(t, mrpRN(3,:),'--', 'LineWidth', 2)
    ylabel('\sigma_{3}')
    grid on
    legend('\sigma_{B/N}','\sigma_{R/N}')

    subplot(4,1,4)
    plot(t, vecnorm(mrpBN,2,1), 'LineWidth', 2)
    hold on
    plot(t, vecnorm(mrpRN,2,1),'--', 'LineWidth', 2)
    ylabel('|\sigma|')
    xlabel('Time [s]')
    grid on
    legend('\sigma_{B/N}','\sigma_{R/N}')

    %% Angular Velocity Plot
    figure;

    subplot(3,1,1)
    plot(t, BwBN(1,:), 'LineWidth', 2)
    hold on
    plot(t, BwRN(1,:),'--', 'LineWidth', 2)
    ylabel('^B\omega_{1} [deg/s]')
    title('Angular Velocity')
    grid on
    legend('^B\omega_{B/N}','^B\omega_{R/N}')

    subplot(3,1,2)
    plot(t, BwBN(2,:), 'LineWidth', 2)
    hold on
    plot(t, BwRN(2,:),'--', 'LineWidth', 2)
    ylabel('^B\omega_{2} [deg/s]')
    grid on
    legend('^B\omega_{B/N}','^B\omega_{R/N}')

    subplot(3,1,3)
    plot(t, BwBN(3,:), 'LineWidth', 2)
    hold on
    plot(t, BwRN(3,:),'--', 'LineWidth', 2)
    ylabel('^B\omega_{3} [deg/s]')
    xlabel('Time [s]')
    grid on
    legend('^B\omega_{B/N}','^B\omega_{R/N}')

    %% Control Plot
    figure;

    subplot(3,1,1)
    plot(t, u(1,:), 'LineWidth', 2)
    ylabel('u_1 [N-m]')
    title('Control Inputs')
    grid on

    subplot(3,1,2)
    plot(t, u(2,:), 'LineWidth', 2)
    ylabel('u_2 [N-m]')
    grid on

    subplot(3,1,3)
    plot(t, u(3,:), 'LineWidth', 2)
    ylabel('u_3 [N-m]')
    xlabel('Time [s]')
    grid on

end