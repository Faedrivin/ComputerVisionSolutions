function text = solveCaptcha( captcha, templates, similarityFunc, scoreFunc, borderOffsets, letterOffset )
%SOLVECAPTCHA Solves a captcha.
%   captcha: the captcha
%   templates: the template letters
%   similarityFunc: e.g. @MAD or @corrCoeff
%   scoreFunc: the score function, called scoreFunc(current, best), updates
%       on a true result (e.g. @gt would update if current > best)
%   borderOffsets: [top right bottom left] for the boundaries
%   letterOffset: [y x] added after each letter to jump to the next
%       (assuming a grid structure)
    a = 0;
    
    % convert everything to gray images
    captcha = rgb2gray(captcha) > 0.1;
    for i = 1 : numel(templates)
        templates{i} = rgb2gray(templates{i});
    end
    imshow(captcha);
    % determine number of characters
    szCaptcha = size(captcha);
    szTemplate = size(templates{1});
    characters = ceil((szCaptcha - borderOffsets([1 2]) - borderOffsets([3 4])) ./ (szTemplate + letterOffset));
    text = repmat(char(0), characters(1), characters(2));

    character = 1;
    for x = borderOffsets(4) : (szTemplate(2) + letterOffset(2)) : (szCaptcha(2) - borderOffsets(2) + letterOffset(2))
        for y = borderOffsets(1) : (szTemplate(1) + letterOffset(1)) : (szCaptcha(1) - borderOffsets(3) + letterOffset(1))
            bestLetter = -32; % blank space
            bestScore = NaN;
            for i = 1 : numel(templates)
                patch = captcha(y : y + szTemplate(1) - 1, x : x + szTemplate(2) - 1);
                score = similarityFunc(patch, templates{i});
                if or(scoreFunc(score, bestScore), isnan(bestScore))
                    bestLetter = i;
                    bestScore = score;
                end
            end
            text(character) = char(64 + bestLetter);
            character = character + 1;
        end
    end
end