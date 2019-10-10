function rank=GradeRank(score)
    switch fix(score/10)
        case 9
            rank='A';
        case 8
            rank='B';
        case 7
            rank='C';
        case 6
            rank='D';
        otherwise
            rank='not pass';
    end
end