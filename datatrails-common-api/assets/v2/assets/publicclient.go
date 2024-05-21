package assets

import (
        "github.com/datatrails/go-datatrails-common/grpcclient"
)

type PublicClient struct {
        g      *grpcclient.Client
        Client PublicAssetsClient
}

func NewPublicClient(log Logger, address string, opts ...ClientOption) *PublicClient {
        return &PublicClient{
                g: grpcclient.New(log, "publicassetsv2", address, opts...),
        }
}

func (c *PublicClient) Open() error {
        if c.Client != nil {
                return nil
        }
        err := c.g.Open()
        if err != nil {
                return err
        }
        c.Client = NewPublicAssetsClient(c.g.Connector())
        return nil
}

func (c *PublicClient) Close() {
        c.g.Close()
}

