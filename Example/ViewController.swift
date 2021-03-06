//
//  ViewController.swift
//  Example
//
//  Created by Marco Betschart on 08.12.17.
//  Copyright © 2017 MANDELKIND. All rights reserved.
//

import Eureka
import SplitRow

class ViewController: FormViewController{

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "SplitRow Examples"
		
		form +++ Section("Phone")
			<<< SplitRow<PushRow<String>,PhoneRow>(){
				$0.rowLeft = PushRow<String>(){
					$0.options = ["work","private","other"]
				}
				
				$0.rowRight = PhoneRow(){
					$0.placeholder = "Phone"
				
				}.cellUpdate{ cell, row in
					cell.textField?.clearButtonMode = .whileEditing
					cell.textField?.textAlignment = .right
					
				}.onCellHighlightChanged{ _, row in
					print("onCellHighlightChanged:",row.isHighlighted,"wasChanged:",row.wasChanged)
				}
				
			}.onChange{ row in
				print("valueChanged:",row.valueChanged)
		}
		
		form +++ Section("E-Mail")
			<<< SplitRow<PushRow<String>,EmailRow>(){
				$0.rowLeft = PushRow<String>(){
					$0.options = ["work","private","other"]
				}
				
				$0.rowRight = EmailRow(){
					$0.placeholder = "E-Mail"
				
				}.cellUpdate{ cell, row in
					cell.textField?.clearButtonMode = .whileEditing
					cell.textField?.textAlignment = .right
				}
		}
		
		form +++ Section("URL")
			<<< SplitRow<PushRow<String>,URLRow>(){
				$0.rowLeft = PushRow<String>(){
					$0.options = ["work","private","other"]
				}
				
				$0.rowRight = URLRow(){
					$0.placeholder = "URL"
				
				}.cellUpdate{ cell, row in
					cell.textField?.clearButtonMode = .whileEditing
					cell.textField?.textAlignment = .right
				}
		}
		
		form +++ MultivaluedSection(multivaluedOptions: [.Insert,.Delete,.Reorder], header: "URLs", footer: ""){
			$0.multivaluedRowToInsertAt = { _ in
				return SplitRow<PushRow<String>,URLRow>(){
					$0.rowLeft = PushRow<String>(){
						$0.options = ["work","private","other"]
					}
					
					$0.rowRight = URLRow(){
						$0.placeholder = "URL"
						
						}.cellUpdate{ cell, row in
							cell.textField?.clearButtonMode = .whileEditing
							cell.textField?.textAlignment = .right
					}
				}
			}
			guard let row = $0.multivaluedRowToInsertAt?(0) else{ return }
			$0 <<< row
		}
	}
}
