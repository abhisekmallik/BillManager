//
//  ThemeTextFieldStyle.swift
//  BillManager
//
//  Created by Abhisek Mallik on 09/02/2023.
//

import FloatingLabelTextFieldSwiftUI

struct ThemeTextFieldStyle: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content
            .spaceBetweenTitleText(15) // Sets the space between title and text.
            .textAlignment(.leading) // Sets the alignment for text.
            .lineHeight(1) // Sets the line height.
            .selectedLineHeight(1.5) // Sets the selected line height.
            .lineColor(.gray) // Sets the line color.
            .selectedLineColor(.blue) // Sets the selected line color.
            .titleColor(.gray) // Sets the title color.
            .selectedTitleColor(.blue) // Sets the selected title color.
            .titleFont(.system(size: 12)) // Sets the title font.
            .textColor(.black) // Sets the text color.
            .selectedTextColor(.blue) // Sets the selected text color.
            .textFont(.system(size: 15)) // Sets the text font.
            .placeholderColor(.gray) // Sets the placeholder color.
            .placeholderFont(.system(size: 15)) // Sets the placeholder font.
            .errorColor(.red) // Sets the error color.
            .addDisableEditingAction([.paste]) // Disable text field editing action. Like cut, copy, past, all etc.
            .enablePlaceholderOnFocus(true) // Enable the placeholder label when the textfield is focused.
            .allowsHitTesting(true) // Whether this view participates in hit test operations.
            .disabled(false) // Whether users can interact with this.
    }
}
