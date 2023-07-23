select *from penjualan p 
select *from pelanggan p2
select *from barang b

alter table penjualan add primary key(id_invoice)
alter table pelanggan add primary key(id_customer)
alter table barang add primary key(kode_barang)

select *from penjualan p where tanggal >='01/01/222' and tanggal <='31/01/22'
order by tanggal asc


## base table
create table base_table as (
	select p.id_invoice, p.id_customer, p.id_distributor, p.id_barang, p.tanggal, p2.nama, p2.cabang_sales as cabang, 
	p2.`group` as group_klink_apotek, b.nama_barang, b.kemasan, p.lini, p.jumlah_barang, p.harga 
	from penjualan p 
	left join pelanggan p2 
	on p.id_customer  = p2.id_customer 
	left join barang b  
	on p.id_barang = b.kode_barang 
) 
select *from base_table bt limit 5

alter table base_table change column group_klink_apotek to kategori

## datamart
create table transaksi as (
	select id_invoice, id_customer, tanggal, nama, cabang, group_klink_apotek, nama_barang, kemasan, 
		lini, jumlah_barang, harga, jumlah_barang*harga as total_harga
	from base_table bt 
)

select *from transaksi limit 5
