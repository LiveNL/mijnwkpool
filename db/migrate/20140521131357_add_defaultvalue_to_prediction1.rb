class AddDefaultvalueToPrediction1 < ActiveRecord::Migration
  def up
      change_column_default :predictions, :prediction1, '0'
  end

  def down
      change_column_default :predictions, :prediction1, nil
  end
end
