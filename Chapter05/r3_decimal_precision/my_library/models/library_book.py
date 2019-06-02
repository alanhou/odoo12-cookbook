# -*- coding: utf-8 -*-
from odoo import models, fields
from odoo.addons import decimal_precision as dp


class LibraryBook(models.Model):
    _name = 'library.book'
    _description = 'Library Book'
    _order = 'date_release desc, name'
    _rec_name = 'short_name'

    name = fields.Char('Title', required=True)
    short_name = fields.Char('Short Title', translate=True, index=True)
    notes = fields.Text('Internal Notes')
    state = fields.Selection(
        [('draft', 'Not Available'),
         ('available', 'Available'),
         ('lost', 'Lost')],
        'State', default="draft")
    description = fields.Html('Description', sanitize=True, strip_style=False)
    cover = fields.Binary('Book Cover')
    out_of_print = fields.Boolean('Out of Print?')
    date_release = fields.Date('Release Date')
    date_updated = fields.Datetime('Last Updated')
    pages = fields.Integer('Number of Pages',
            groups="base.group_user",
            state={'lost': [('readonly', True)]},
            help="Total book page count", company_dependent=False)
    reader_rating = fields.Float(
        'Reader Average Rating',
        digits=(14, 4), # 可选精度（总数，小数）
    )
    author_ids = fields.Many2many(
        'res.partner',
        string='Authors'
    )
    cost_price = fields.Float('Book Cost', digits=dp.get_precision('Book Price'))

    def name_get(self):
        """ 这个方法用于自定义记录的显示名称 """
        result = []
        for record in self:
            rec_name = "%s (%s)" % (record.name, record.date_release)
            result.append((record.id, rec_name))
        return result