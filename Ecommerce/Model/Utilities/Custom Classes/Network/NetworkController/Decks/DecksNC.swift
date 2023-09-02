//
//  DecksNC.swift
//  SHOTDECK
//
//  Created by Shotdeck_developer on 21/11/22.
//

import Foundation
import UIKit

class DecksNC: BaseNetworkController {
    
    //MARK: - Get Decks
    
    func getDecks(completion: ((DecksResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .decks) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var decksResponse: DecksResponse?
                if let data = data
                {
                    decksResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if decksResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(decksResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(decksResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(decksResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    //MARK: - Get Decks Details
    
    func getDecksDetails(deckID:String?,completion: ((DeckDetailsResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .deckDetail,deckID: deckID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var deckDetailsResponse: DeckDetailsResponse?
                if let data = data
                {
                    deckDetailsResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if deckDetailsResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(deckDetailsResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(deckDetailsResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(deckDetailsResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
    //MARK: - Rename Decks
    
    func renameDeck(deckID:String?,renameDeckRequest: RenameDeckRequest,completion: ((RenameDeckResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .Renamedecks, deckID: deckID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestObj.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(renameDeckRequest)
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var renameDeckResponse: RenameDeckResponse?
                if let data = data
                {
                    renameDeckResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if renameDeckResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(renameDeckResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(renameDeckResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(renameDeckResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    //MARK: - Create Decks
    
    func createNewDeck(createNEWDeckRequest: CreateNEWDeckRequest,completion: ((CreateNewDeckResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .CreateNewDeck) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestObj.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(createNEWDeckRequest)
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var createNewDeckResponse: CreateNewDeckResponse?
                if let data = data
                {
                    createNewDeckResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if createNewDeckResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(createNewDeckResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(createNewDeckResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(createNewDeckResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
    //MARK: - Remove image from Decks
    
    func removeImageFromDeck(deckID:String?,imageID:String?,completion: ((RemoveImageFromDeckResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .removeImageFromDeck,deckID: deckID,imageID: imageID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var removeImageFromDeckResponse: RemoveImageFromDeckResponse?
                if let data = data
                {
                    removeImageFromDeckResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if removeImageFromDeckResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(removeImageFromDeckResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(removeImageFromDeckResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(removeImageFromDeckResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    //MARK: - Get Existing Deck List for Add to deck
    
    func getAddToDeckExistingList(getExistingDeckListRequest: GetExistingDeckListRequest, completion: ((GetDecksForAddToDeckResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestUrl = try RequestBuilder().getRequestObject(api: .GetAddTodeckExistingList) else {
                let errorMsg = "Unable to build request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestUrl = requestUrl.appendQueryParams(queryPrams: getExistingDeckListRequest)!
            return addOperation(request: requestUrl) {
                data, response, responseStatus in
                var getDecksForAddToDeckResponse: GetDecksForAddToDeckResponse?
                if let data = data
                {
                    getDecksForAddToDeckResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if getDecksForAddToDeckResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(getDecksForAddToDeckResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(getDecksForAddToDeckResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(getDecksForAddToDeckResponse, responseStatus)
                    }
                }
                
            }
        }
        catch {
            return nil
        }
    }
    
    
    //MARK: -  ADd image To Decks
    
    func addImagesToDeck(deckID:String?,imageID:String?,completion: ((AddImagesToDeckResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard let requestObj = try RequestBuilder().getRequestObject(api: .addImageToDeck,deckID: deckID,imageID: imageID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var addImagesToDeckResponse: AddImagesToDeckResponse?
                if let data = data
                {
                    addImagesToDeckResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if addImagesToDeckResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(addImagesToDeckResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(addImagesToDeckResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(addImagesToDeckResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
    //MARK: -  ADd Caption to image To Decks
    
    func addCaptionToImages(addCaptionToDeckRequest:addCaptionToDeckRequest,deckID:String?,imageID:String? ,completion: ((AddCaptionForImageResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .addCaptionToDeck,deckID: deckID,imageID: imageID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestObj.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(addCaptionToDeckRequest)
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var addCaptionForImageResponse: AddCaptionForImageResponse?
                if let data = data
                {
                    addCaptionForImageResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if addCaptionForImageResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(addCaptionForImageResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(addCaptionForImageResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(addCaptionForImageResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    //MARK: -  Share Decks
    
    func shareDeckAPI(shareDeckRequest:shareDeckRequest,deckID:String?,completion: ((ShareDeckResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .shareDeck,deckID: deckID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestObj.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(shareDeckRequest)
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var shareDeckResponse: ShareDeckResponse?
                if let data = data
                {
                    shareDeckResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if shareDeckResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(shareDeckResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(shareDeckResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(shareDeckResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    //MARK: -  Export Decks
    
    func exportDeck(exportDeckRequest :ExportDeckRequest,deckID:String?,completion: ((Data?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .exportDeck,deckID:deckID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestObj = requestObj.appendQueryParams(queryPrams: exportDeckRequest)!
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                if let data = data
                {
                    DispatchQueue.main.async {
                        completion?(data, responseStatus)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        completion?(data, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    func SearchDecks(searchDeckRequest:SearchDeckRequest?,completion: ((SearchDecksResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .search_decks) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            
            requestObj = requestObj.appendQueryParams(queryPrams: searchDeckRequest)!
            
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var searchDecksResponse: SearchDecksResponse?
                if let data = data
                {
                    searchDecksResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if searchDecksResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(searchDecksResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(searchDecksResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(searchDecksResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
    //MARK: -  Trash Decks
    
    func trashDeckAPI(trashRequest:TrashRequest,deckID:String?,completion: ((ReorderDecksResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .Decks_order,deckID: deckID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestObj.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(trashRequest)
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var reorderDecksResponse: ReorderDecksResponse?
                if let data = data
                {
                    reorderDecksResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if reorderDecksResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(reorderDecksResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(reorderDecksResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(reorderDecksResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
    //MARK: -  Archieve Decks
    
    func archiveDeckAPI(archieveRequest:ArchieveRequest,deckID:String?,completion: ((ReorderDecksResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .Decks_order,deckID: deckID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestObj.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledData(archieveRequest)
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var reorderDecksResponse: ReorderDecksResponse?
                if let data = data
                {
                    reorderDecksResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if reorderDecksResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(reorderDecksResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(reorderDecksResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(reorderDecksResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    
    //MARK: - ReORDER Deck Shots
    
    func reOrderDeckShots(deckID:String?,reOrderDeckShotRequest: Dictionary <String, AnyObject>?,completion: ((DeckDetailsResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .Deck_shots_order, deckID: deckID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestObj.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledDictionary(reOrderDeckShotRequest!)
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var deckDetailsResponse: DeckDetailsResponse?
                if let data = data
                {
                    deckDetailsResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if deckDetailsResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(deckDetailsResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(deckDetailsResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(deckDetailsResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
    //MARK: - ReORDER MOVE Decks
    
    func moveReorderDeck(deckID:String?,parentID:String?,moveReorderDeckRequest: Dictionary <String, AnyObject>?,completion: ((ReorderDecksResponse?, ResponseStatus) -> Void)?) -> BaseOperation? {
        do {
            guard var requestObj = try RequestBuilder().getRequestObject(api: .Decks_Reorder_Move, deckID: deckID,parentID: parentID) else {
                let errorMsg = "Unable to build getAppSettings request object."
                print(errorMsg)
                completion?(nil, ResponseStatus(errorMessage: errorMsg, errorCode: InAppErrorCodes.invalildRequest.rawValue, httpStatusCode: 0))
                return nil
            }
            requestObj.httpBody = BaseNetworkController.encodeBodyURLEncodedEnabledDictionary(moveReorderDeckRequest!)
            return addOperation(request: requestObj) {
                data, response, responseStatus in
                var reorderDecksResponse: ReorderDecksResponse?
                if let data = data
                {
                    reorderDecksResponse = BaseNetworkController.decodeData(data: data)
                    if responseStatus.statusCode == 401{
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            Common.shared.logout()
                        }
                    }else{
                        if reorderDecksResponse?.success  == false {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                                completion?(reorderDecksResponse, responseStatus)
                            }
                        }else{
                            DispatchQueue.main.async {
                                completion?(reorderDecksResponse, responseStatus)
                            }
                        }
                    }
                }  else {
                    DispatchQueue.main.async {
                        completion?(reorderDecksResponse, responseStatus)
                    }
                }
            }
        } catch {
            return nil
        }
    }
    
}
