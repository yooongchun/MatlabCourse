function fractal_leaf(number_of_points)
    Mat1 = [0 0;0 0.16];
    Mat2 = [0.85 0.04;-0.04 0.85];
    Mat3 = [0.2 -0.26;0.23 0.22];
    Mat4 = [-0.15 0.28;0.26 0.24];
    Vector1 = [0;0];
    Vector2 = [0;1.6];
    Vector3 = [0;1.6];
    Vector4 = [0;0.44];
    Prob1 = 0.01;
    Prob2 = 0.85;
    Prob3 = 0.07;
    P = [0;0];
    x = zeros(1,number_of_points);
    y = zeros(1,number_of_points);
    prob = rand(number_of_points,1);
    for counter = 1:number_of_points
        if prob(counter)<Prob1
            P=Mat1*P+Vector1;
        elseif prob(counter)<Prob1+Prob2
            P=Mat2*P+Vector2;
        elseif prob(counter)<Prob1+Prob2+Prob3
            P=Mat3*P+Vector3;
        else
            P=Mat4*P+Vector4;
        end
        x(counter)=P(1);
        y(counter)=P(2);
    end
    plot(x,y,'b.')
    text(3,5,['n:',num2str(number_of_points)],'EdgeColor','r','FontSize',20,'LineWidth',2);
    axis equal, axis off
end