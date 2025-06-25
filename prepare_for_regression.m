function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
  [n, m] = size(InitialMatrix);
  FeatureMatrix = zeros(n, m + 1);

  for i = 1:n
    offset = 0;
    for j = 1:m
      val = InitialMatrix{i, j};
      num = str2double(val);

      if ~isnan(num)
        FeatureMatrix(i, j + offset) = num;
      else
        if strcmpi(val, 'yes')
          FeatureMatrix(i, j + offset) = 1;
        elseif strcmpi(val, 'no')
          FeatureMatrix(i, j + offset) = 0;
        elseif strcmpi(val, 'furnished')
          offset = 1;
        elseif strcmpi(val, 'unfurnished')
          FeatureMatrix(i, j + 1) = 1;
          offset = 1;
        elseif strcmpi(val, 'semi-furnished')
          FeatureMatrix(i, j) = 1;
          offset = 1;
        end
      end
    end
  end
end

