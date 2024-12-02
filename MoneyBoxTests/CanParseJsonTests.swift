//
//  CanParseJsonTests.swift
//  MoneyBoxTests
//
//  Created by Rodrigo Peña on 27/11/24.
//

import XCTest
import Networking
@testable import MoneyBox

final class CanParseJsonTests: XCTestCase {
    
    func testCanParseLoginResponse() throws {
        let json = """
        {
        "User": {
            "Email": "test+ios@moneyboxapp.com",
            "FirstName": "Michael",
            "LastName": "Jordan"
        },
        "Session": {
            "BearerToken": "GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs="
         }
        }
        """
        
        let data = json.data(using: .utf8)!
        let result = try! JSONDecoder().decode(LoginResponse.self, from: data)
        XCTAssertEqual(result.user.firstName, "Michael")
        XCTAssertEqual(result.user.lastName, "Jordan")
        XCTAssertEqual(result.session.bearerToken, "GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs=")
    }
    
    func testCanParseAccountResponse() throws {
        let json = """
        {
            "MoneyboxEndOfTaxYear": "2022-03-23T12:00:00.000",
            "TotalPlanValue": 15707.080000,
            "TotalEarnings": 2353.480000,
            "TotalContributionsNet": 13355.42,
            "TotalEarningsAsPercentage": 17.62,
            "ProductResponses": [
                {
                    "Id": 8043,
                    "AssetBoxGlobalId": "cf0a49dd-a8cf-4b59-82ee-9215558cce8d",
                    "PlanValue": 10526.09,
                    "Moneybox": 570.00,
                    "SubscriptionAmount": 0.00,
                    "TotalFees": 36.83,
                    "IsSelected": false,
                    "IsFavourite": false,
                    "CollectionDayMessage": "3 days until collection",
                    "WrapperId": "b9eaa523-cdd5-46c6-8353-9d538da845e0",
                    "IsCashBox": false,
                    "PendingInstantBankTransferAmount": 0.0,
                    "AssetBox": {
                        "Title": "Investments"
                    },
                    "Product": {
                        "Id": 1,
                        "Name": "ISA",
                        "CategoryType": "Investment",
                        "Type": "Isa",
                        "FriendlyName": "Stocks & Shares ISA",
                        "CanWithdraw": true,
                        "ProductHexCode": "#c5d561",
                        "AnnualLimit": 20000.00,
                        "DepositLimit": 0.00,
                        "BonusMultiplier": 0.00,
                        "MinimumWeeklyDeposit": 2.0,
                        "MaximumWeeklyDeposit": 400.0,
                        "Documents": {
                            "KeyFeaturesUrl": "https://api-test02.moneyboxapp.com/docs/KeyFeaturesDocumentAll"
                        },
                        "State": "None",
                        "WrapperDefinitionGlobalId": "ecdf7923-4f30-4e9d-84bc-1e71d3a53367"
                    },
                    "InvestorAccount": {
                        "ContributionsNet": 9243.00,
                        "EarningsNet": 1283.09,
                        "EarningsAsPercentage": 13.88
                    },
                    "Personalisation": {
                        "QuickAddDeposit": {
                            "Amount": 100.00
                        },
                        "HideAccounts": {
                            "Enabled": false,
                            "IsHidden": false,
                            "Sequence": 1
                        }
                    },
                    "Contributions": {
                        "Status": "Enabled"
                    },
                    "MoneyboxCircle": {
                        "State": "None"
                    },
                    "IsSwitchVisible": false,
                    "State": "None",
                    "DateCreated": "2020-07-17T14:37:32.630"
                },
                {
                    "Id": 8042,
                    "AssetBoxGlobalId": "b6a061d1-cfdf-45a0-9177-e89d69c9bd28",
                    "PlanValue": 5180.990000,
                    "Moneybox": 470.00,
                    "SubscriptionAmount": 0.00,
                    "TotalFees": 0.00,
                    "IsSelected": true,
                    "IsFavourite": true,
                    "CollectionDayMessage": "3 days until collection",
                    "WrapperId": "e7bdfeb4-23c7-44d6-88f5-04dc0c7ab99d",
                    "IsCashBox": false,
                    "PendingInstantBankTransferAmount": 0.0,
                    "AssetBox": {
                        "Title": "Cash"
                    },
                    "Product": {
                        "Lisa": {
                            "MaximumBonus": 1000.0000
                        },
                        "Id": 7,
                        "Name": "Lisa Plus",
                        "CategoryType": "Cash",
                        "Type": "Lisa",
                        "FriendlyName": "Lifetime ISA",
                        "CanWithdraw": false,
                        "ProductHexCode": "#49bfbd",
                        "AnnualLimit": 4000.00,
                        "DepositLimit": 0.00,
                        "BonusMultiplier": 0.25,
                        "MinimumWeeklyDeposit": 2.0,
                        "MaximumWeeklyDeposit": 400.0,
                        "InterestRate": "0.35% AER",
                        "InterestRateAmount": 0.003500,
                        "LogoUrl": "https://assets.moneyboxapp.com/images/app-assets/InvestecIconRebrand.png",
                        "Documents": {
                            "KeyFeaturesUrl": "https://api-test02.moneyboxapp.com/docs/KeyFeaturesDocumentAll"
                        },
                        "State": "None",
                        "WrapperDefinitionGlobalId": "7b98e517-7a1f-4526-8266-b8ce0b9f8199",
                        "Fund": {
                            "FundId": 37,
                            "Name": "Investec",
                            "LogoUrl": "https://assets.moneyboxapp.com/images/app-assets/InvestecIconRebrand.png",
                            "IsFundDMB": false
                        }
                    },
                    "InvestorAccount": {
                        "TodaysInterest": 0.0433,
                        "ContributionsNet": 4112.42,
                        "EarningsNet": 1070.390000,
                        "EarningsAsPercentage": 25.97
                    },
                    "Personalisation": {
                        "QuickAddDeposit": {
                            "Amount": 100.00
                        },
                        "HideAccounts": {
                            "Enabled": false,
                            "IsHidden": false,
                            "Sequence": 2
                        }
                    },
                    "Contributions": {
                        "Status": "Enabled"
                    },
                    "MoneyboxCircle": {
                        "State": "None"
                    },
                    "IsSwitchVisible": false,
                    "State": "None",
                    "DateCreated": "2020-07-17T14:36:09.957"
                }
            ],
            "Accounts": [
                {
                    "Type": "Isa",
                    "Name": "Stocks & Shares ISA",
                    "DeepLinkIdentifier": "Isa",
                    "Wrapper": {
                        "Id": "b9eaa523-cdd5-46c6-8353-9d538da845e0",
                        "DefinitionGlobalId": "ecdf7923-4f30-4e9d-84bc-1e71d3a53367",
                        "TotalValue": 10526.090000,
                        "TotalContributions": 9243.00,
                        "EarningsNet": 1283.090000,
                        "EarningsAsPercentage": 13.88,
                        "Returns": {
                            "Simple": 13.88,
                            "Lifetime": 19.890000,
                            "Annualised": 13.148500
                        }
                    },
                    "Milestone": {
                        "InitialStage": "investments_initial",
                        "EndStage": "investments_initial",
                        "EndStageId": 2
                    },
                    "HasCollections": true
                },
                {
                    "Type": "Lisa",
                    "Name": "Lifetime ISA",
                    "DeepLinkIdentifier": "Lisa",
                    "Wrapper": {
                        "Id": "e7bdfeb4-23c7-44d6-88f5-04dc0c7ab99d",
                        "DefinitionGlobalId": "7b98e517-7a1f-4526-8266-b8ce0b9f8199",
                        "TotalValue": 5180.990000,
                        "TotalContributions": 4365.00,
                        "EarningsNet": 1070.390000,
                        "EarningsAsPercentage": 25.97,
                        "Returns": {
                            "Simple": 25.97,
                            "Lifetime": 28.870000,
                            "Annualised": 18.853000
                        }
                    },
                    "Milestone": {
                        "InitialStage": "lisa_first_house",
                        "EndStage": "lisa_second_house",
                        "EndStageId": 5
                    },
                    "HasCollections": true
                }
            ]
        }
      """
        
        let data = json.data(using: .utf8)!
        let result = try! JSONDecoder().decode(AccountResponse.self, from: data)
        
        // Assert top-level fields
        XCTAssertEqual(result.moneyboxEndOfTaxYear, "2022-03-23T12:00:00.000")
        XCTAssertEqual(result.totalPlanValue, 15707.08)
        XCTAssertEqual(result.totalEarnings, 2353.48)
        // ... (other top-level fields)
        
        // Assert on the first ProductResponse
        let firstProductResponse = result.productResponses?[0]
        XCTAssertEqual(firstProductResponse?.id , 8043)
        XCTAssertEqual(firstProductResponse?.assetBoxGlobalID, "cf0a49dd-a8cf-4b59-82ee-9215558cce8d")
        XCTAssertEqual(firstProductResponse?.planValue, 10526.09)
        // ... (other fields of the first ProductResponse)
        
        // Assert on the second ProductResponse
        let secondProductResponse = result.productResponses?[1]
        XCTAssertEqual(secondProductResponse?.id, 8042)
        XCTAssertEqual(secondProductResponse?.assetBoxGlobalID, "b6a061d1-cfdf-45a0-9177-e89d69c9bd28")
        XCTAssertEqual(secondProductResponse?.planValue, 5180.99)
        // ... (other fields of the second ProductResponse)
        
        // Assert on the first Account
        let firstAccount = result.accounts?[0]
        XCTAssertEqual(firstAccount?.type, "Isa")
        XCTAssertEqual(firstAccount?.name, "Stocks & Shares ISA")
        XCTAssertEqual(firstAccount?.wrapper?.totalValue, 10526.09)
        // ... (other fields of the first Account)
        
        // Assert on the second Account
        let secondAccount = result.accounts?[1]
        XCTAssertEqual(secondAccount?.type, "Lisa")
        XCTAssertEqual(secondAccount?.name, "Lifetime ISA")
        XCTAssertEqual(secondAccount?.deepLinkIdentifier, "Lisa")
        XCTAssertEqual(secondAccount?.wrapper?.id, "e7bdfeb4-23c7-44d6-88f5-04dc0c7ab99d")
        XCTAssertEqual(secondAccount?.wrapper?.definitionGlobalID, "7b98e517-7a1f-4526-8266-b8ce0b9f8199")
        XCTAssertEqual(secondAccount?.wrapper?.totalValue, 5180.99)
        XCTAssertEqual(secondAccount?.wrapper?.totalContributions, 4365)
        XCTAssertEqual(secondAccount?.wrapper?.earningsNet, 1070.39)
        XCTAssertEqual(secondAccount?.wrapper?.earningsAsPercentage, 25.97)
        XCTAssertEqual(secondAccount?.wrapper?.returns?.simple, 25.97)
        XCTAssertEqual(secondAccount?.wrapper?.returns?.lifetime, 28.87)
        XCTAssertEqual(secondAccount?.wrapper?.returns?.annualised, 18.853)
        XCTAssertEqual(secondAccount?.milestone?.initialStage, "lisa_first_house")
        XCTAssertEqual(secondAccount?.milestone?.endStage, "lisa_second_house")
        XCTAssertEqual(secondAccount?.milestone?.endStageID, 5)
        XCTAssertEqual(secondAccount?.hasCollections, true)
    }
}
