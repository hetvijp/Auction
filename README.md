# Auction Group 30

Admin Credentials
- Username: Group30Admin
- Password: 336ProjectG30

Customer Rep Credentials (username, password)
- hpatel, hpatelg30
- tpatel, tpatelg30
- dpatel, dpatelg30

Group Roles
- Part II Functionality: Zachary Tarman
- Part III Functionality: Hetvi Patel
- Part IV Functionality: Daksh Patel
- Part V Functionality: Tapan Patel

Database/Design Clarifications
- There are a few boolean attributes utilized throughout:
	- One is simply used for alert functionality (new_high in auto_bids). TRUE indicates an alert needs to be given to a user that someone bid higher than them.
	- One is used to signal which auctions are closed and with the item purchased (sold in auction).
	- Several are within the technology subclasses (solid_state_drive and tablet_convertible in laptop, EKG and cell_enabled in smartwatch).
		- TRUE indicates that this product has that attribute (e.g., TRUE means a laptop has a solid state drive).

- On a more conceptual level, the tuples in the technology table store unique products, and then each auction where sold = TRUE marks a new "item" of that product that's been sold.
	- Users can create a new product to be stored if the item they want to sell doesn't match one of the existing products.
	- A product will be either a phone, smartwatch, or a laptop (static types).
		- The only reason that the ER diagram says "partial" is that there aren't only those types of technology in reality, but in our application, you can only enter those three types.

- Every first bid (manual OR automatic) will create an auto_bids tuple.
	- If a user is just manually bidding on an auction, then the upper bound and increment fields in their tuple will be set to NULL.
	- If a user is setting up automatic bidding on an auction, then the upper bound and increment fields in their tuple will be set accordingly.

- Every single bid will be stored as a tuple in the bids table.
	- Every individual bid is recorded here so that we can have a history of bids for every auction.
