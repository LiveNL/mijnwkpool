class AddDefaultvalueToPrediction2 < ActiveRecord::Migration
  def up
      change_column_default :predictions, :prediction2, '0'
  end

  def down
      change_column_default :predictions, :prediction2, nil
  end
end


