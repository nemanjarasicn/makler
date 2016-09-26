"""Alter columns announced, created and valid_until to timestamp without time zone.

Revision ID: 581bc17aeee3
Revises:
Create Date: 2016-09-26 11:43:25.086003

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

revision = '581bc17aeee3'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    op.alter_column('contracts', 'announced',
                    existing_type=postgresql.TIMESTAMP(timezone=True), type_=sa.DateTime(), existing_nullable=True)
    op.alter_column('contracts', 'created',
                    existing_type=postgresql.TIMESTAMP(timezone=True),
                    type_=sa.DateTime(),
                    existing_nullable=True)
    op.alter_column('contracts', 'valid_until',
                    existing_type=postgresql.TIMESTAMP(timezone=True),
                    type_=sa.DateTime(),
                    existing_nullable=True)


def downgrade():
    op.alter_column('contracts', 'valid_until',
                    existing_type=sa.DateTime(),
                    type_=postgresql.TIMESTAMP(timezone=True),
                    existing_nullable=True)
    op.alter_column('contracts', 'created',
                    existing_type=sa.DateTime(),
                    type_=postgresql.TIMESTAMP(timezone=True),
                    existing_nullable=True)
    op.alter_column('contracts', 'announced',
                    existing_type=sa.DateTime(),
                    type_=postgresql.TIMESTAMP(timezone=True),
                    existing_nullable=True)
