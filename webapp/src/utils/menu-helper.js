const orderMenu = {
    "M-1": "Classic Burger",
    "M-2": "Vegetarian Pizza",
    "M-3": "Grilled Chicken Salad",
    "M-4": "Pasta Alfredo",
    "M-5": "Fish and Chips",
    "M-6": "Steak Sandwich",
    "M-7": "Caesar Salad",
    "M-8": "Margherita Pizza",
    "M-9": "BBQ Ribs",
    "M-10": "Mushroom Risotto"
  };
  
export const constructMenuItems = (items) => {
      let itemString = "";
      if (items === undefined) return "";
      items.map((item) => { itemString += orderMenu[item] + ", "; });
      return itemString.substring(0, itemString.length - 2);
  };