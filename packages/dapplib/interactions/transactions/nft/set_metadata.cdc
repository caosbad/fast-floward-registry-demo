import RegistryNFTContract from Registry.RegistryNFTContract
import NonFungibleToken from Flow.NonFungibleToken

// This transaction is used to transfer an NFT from acct --> recipient

transaction(id: UInt64, metadata: String) {
  let ownerNFTCollectionRef: &RegistryNFTContract.Collection

  prepare(acct: AuthAccount) {
      self.ownerNFTCollectionRef = acct.borrow<&RegistryNFTContract.Collection>(from: /storage/NFTCollection)
        ?? panic("Could not borrow the user's NFT Collection")
  } 

  execute {
      
    let nft = self.ownerNFTCollectionRef.borrowEntireNFT(id: id)! as &RegistryNFTContract.NFT
    nft.setMetadata(metadata)

      log("Transfered the NFT from the giver to the recipient")
  }
}