function plot_attitude_sim(t,X,Xr,Xe,u,switch_idx,switch_modes,constants)

    % Extract states and reference states
    mrpBN = X(1:3,:);
    BwBN = rad2deg(X(4:6,:));
    mrpRN = Xr(1:3,:);
    BwRN = rad2deg(Xr(4:6,:));
    mrpBR = Xe(1:3,:);
    BwBR = rad2deg(Xe(4:6,:));

    %% MRP Plot
    figure;

    subplot(4,1,1)
    plot(t, mrpBN(1,:), 'LineWidth', 2)
    hold on
    plot(t, mrpRN(1,:),'--', 'LineWidth', 2)
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('\sigma_{1}')
    title('Modified Rodrigues Parameters')
    grid on
    legend('\sigma_{B/N}','\sigma_{R/N}')

    subplot(4,1,2)
    plot(t, mrpBN(2,:), 'LineWidth', 2)
    hold on
    plot(t, mrpRN(2,:),'--', 'LineWidth', 2)
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('\sigma_{2}')
    grid on
    legend('\sigma_{B/N}','\sigma_{R/N}')

    subplot(4,1,3)
    plot(t, mrpBN(3,:), 'LineWidth', 2)
    hold on
    plot(t, mrpRN(3,:),'--', 'LineWidth', 2)
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('\sigma_{3}')
    grid on
    legend('\sigma_{B/N}','\sigma_{R/N}')

    subplot(4,1,4)
    plot(t, vecnorm(mrpBN,2,1), 'LineWidth', 2)
    hold on
    plot(t, vecnorm(mrpRN,2,1),'--', 'LineWidth', 2)
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
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
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('^B\omega_{1} [deg/s]')
    title('Angular Velocity')
    grid on
    legend('^B\omega_{B/N}','^B\omega_{R/N}')

    subplot(3,1,2)
    plot(t, BwBN(2,:), 'LineWidth', 2)
    hold on
    plot(t, BwRN(2,:),'--', 'LineWidth', 2)
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('^B\omega_{2} [deg/s]')
    grid on
    legend('^B\omega_{B/N}','^B\omega_{R/N}')

    subplot(3,1,3)
    plot(t, BwBN(3,:), 'LineWidth', 2)
    hold on
    plot(t, BwRN(3,:),'--', 'LineWidth', 2)
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('^B\omega_{3} [deg/s]')
    xlabel('Time [s]')
    grid on
    legend('^B\omega_{B/N}','^B\omega_{R/N}')

    %% Control Plot
    figure;

    subplot(3,1,1)
    plot(t, u(1,:), 'LineWidth', 2)
    hold on
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('u_1 [N-m]')
    title('Control Inputs')
    grid on

    subplot(3,1,2)
    plot(t, u(2,:), 'LineWidth', 2)
    hold on
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('u_2 [N-m]')
    grid on

    subplot(3,1,3)
    plot(t, u(3,:), 'LineWidth', 2)
    hold on
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('u_3 [N-m]')
    xlabel('Time [s]')
    grid on

    %% MRP Error Plot
    figure;

    subplot(3,1,1)
    plot(t, mrpBR(1,:), 'LineWidth', 2)
    hold on
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('\sigma_{1}')
    title('Modified Rodrigues Parameters Attitude Errors')
    grid on
    legend('\sigma_{B/R}')

    subplot(3,1,2)
    plot(t, mrpBR(2,:), 'LineWidth', 2)
    hold on
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('\sigma_{2}')
    grid on
    legend('\sigma_{B/R}')

    subplot(3,1,3)
    plot(t, mrpBR(3,:), 'LineWidth', 2)
    hold on
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('\sigma_{3}')
    grid on
    legend('\sigma_{B/R}')

    %% Angular Velocity Error Plot
    figure;

    subplot(3,1,1)
    plot(t, BwBR(1,:), 'LineWidth', 2)
    hold on
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('^B\omega_{1} [deg/s]')
    title('Angular Velocity Errors')
    grid on
    legend('^B\omega_{B/R}')

    subplot(3,1,2)
    plot(t, BwBR(2,:), 'LineWidth', 2)
    hold on
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('^B\omega_{2} [deg/s]')
    grid on
    legend('^B\omega_{B/R}')

    subplot(3,1,3)
    plot(t, BwBR(3,:), 'LineWidth', 2)
    hold on
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('^B\omega_{3} [deg/s]')
    xlabel('Time [s]')
    grid on
    legend('^B\omega_{B/R}')

    %% Angular Momentum and Energy
    for i = 1:length(t)
        BH(:,i) = constants.I*BwBN(:,i);
        T(i) = 0.5*BwBN(:,i)'*constants.I*BwBN(:,i);
    end

    figure;

    subplot(2,1,1)
    plot(t, vecnorm(BH,2,1), 'LineWidth', 2)
    hold on
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('^BH [kg-m^2/s]')
    title('Angular Momentum Magnitude')
    grid on

    subplot(2,1,2)
    plot(t, T, 'LineWidth', 2)
    hold on
    for i = 1:length(switch_idx)
        xline(t(switch_idx(i)), ':w', switch_modes{i}, ...
            'LineWidth', 2, 'LabelOrientation', 'horizontal','FontSize', 14);
    end
    ylabel('T [J]')
    title('Kinetic Energy')
    xlabel('Time [s]')
    grid on

end