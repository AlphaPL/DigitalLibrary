module PossessionsHelper

  def how_many_orders_of(copy)
    Possession.where(borrowed_id: copy.id).length 
  end

  def position_in_line_of(user, copy)
    orders = Possession.where(borrowed_id: copy.id)
    increment = 0
    which = 0
    for i in orders 
      increment += 1
      if (i.borrower_id == user.id)
        which = increment
        break
      end
    end
    which
  end

  def top_action(copy)
    top_status = Possession.where(borrowed_id: copy.id).first.specifier
    if top_status == "active"
      "Return book"
    else
      "Borrow book"
    end
  end

  def can_unorder?(user, copy)
    Possession.where(borrowed_id: copy.id, borrower_id: current_user.id).first.specifier != "active"
  end

  def estimated_return_time_of(copy)
    Possession.where(borrowed_id: copy.id).first.created_at + 1.month
  end

end
