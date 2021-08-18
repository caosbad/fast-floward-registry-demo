import RegistryNFTContract from Registry.RegistryNFTContract

pub fun main(acct: Address, id: UInt64): String {
  let acctNFTCollectionRef = getAccount(acct).getCapability(/public/NFTCollection)
            .borrow<&RegistryNFTContract.Collection{RegistryNFTContract.INFTCollectionPublic}>()
            ?? panic("Could not borrow the public capability for the recipient's account")
  let borrowedNFT = acctNFTCollectionRef.borrowEntireNFT(id: id)
    ?? panic("Could not borrow the NFT from the user's collection")
  let metadata: String = RegistryNFTContract.baseUri.concat(borrowedNFT.metadata) 
  return metadata
}